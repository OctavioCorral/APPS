<?php
include("conector.php");
include("funciones.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recibes los campos del formulario
    $idHorario = $_POST['idHorario']; // Asegúrate de enviar este dato desde tu formulario
    $horaInicio = $_POST['hora_inicio'];
    $horaFin = $_POST['hora_fin'];
    $maestroMateria = $_POST['maestromateria'];

    // Iniciar la transacción
    mysqli_begin_transaction($conexion);

    try {
           // Obtener la semana del horario actual
$querySemana = "SELECT Semana FROM Horario WHERE ID_Horario = ?";
$stmtSemana = mysqli_prepare($conexion, $querySemana);
mysqli_stmt_bind_param($stmtSemana, 'i', $idHorario);
mysqli_stmt_execute($stmtSemana);
mysqli_stmt_bind_result($stmtSemana, $semanaHorario);
mysqli_stmt_fetch($stmtSemana);
mysqli_stmt_close($stmtSemana);

        // Consulta para obtener el horario actual
        $queryHorarioActual = "SELECT Dia, HoraInicio, ID_MaestroMateria FROM DetalleHorario WHERE ID_Horario = ?";
        $stmtHorarioActual = mysqli_prepare($conexion, $queryHorarioActual);
        mysqli_stmt_bind_param($stmtHorarioActual, 'i', $idHorario);
        mysqli_stmt_execute($stmtHorarioActual);
        $resultadoHorarioActual = mysqli_stmt_get_result($stmtHorarioActual);

        // Crear un array para almacenar el horario actual
        $horarioActual = [];
        while ($detalle = mysqli_fetch_assoc($resultadoHorarioActual)) {
            $horarioActual[$detalle['Dia']][$detalle['HoraInicio']] = $detalle['ID_MaestroMateria'];
        }
        mysqli_stmt_close($stmtHorarioActual);

        // Comparar el horario actual con el nuevo
        $cambiosEnElHorario = $horarioActual !== $maestroMateria;

        // Si hay cambios, procede con las actualizaciones
        if ($cambiosEnElHorario) {
            // Elimina los detalles del horario existente
            $queryEliminarDetalles = "DELETE FROM DetalleHorario WHERE ID_Horario = ?";
            $stmtEliminarDetalles = mysqli_prepare($conexion, $queryEliminarDetalles);
            mysqli_stmt_bind_param($stmtEliminarDetalles, 'i', $idHorario);
            mysqli_stmt_execute($stmtEliminarDetalles);
            mysqli_stmt_close($stmtEliminarDetalles);

            // Restablecer las horas restantes de las materias que estaban en el horario original
            foreach ($horarioActual as $dia => $valoresDia) {
                foreach ($valoresDia as $horaInicioActual => $idMaestroMateria) {
                    // Restaura las horas restantes de las materias originales
                    $queryRestaurarHoras = "UPDATE Materia SET horas_impartidas = horas_impartidas - 1 WHERE ID_Materia = (SELECT ID_Materia FROM MaestroMateria WHERE id_maestro_materia = ?)";
                    $stmtRestaurarHoras = mysqli_prepare($conexion, $queryRestaurarHoras);
                    mysqli_stmt_bind_param($stmtRestaurarHoras, 'i', $idMaestroMateria);
                    mysqli_stmt_execute($stmtRestaurarHoras);
                    mysqli_stmt_close($stmtRestaurarHoras);
                }
            }

            foreach ($maestroMateria as $dia => $valoresDia) {
                foreach ($valoresDia as $horaInicioActual => $idMaestroMateria) {
                    if ($idMaestroMateria !== '') {
                        $horaFinActual = date('H:i:s', strtotime($horaInicioActual . ' + 1 hour'));
            
                        // Obtener las horas impartidas actuales antes de la actualización
                        $queryHorasActuales = "SELECT m.Horas_impartidas
                                               FROM Materia m
                                               JOIN MaestroMateria mm ON m.ID_Materia = mm.ID_Materia
                                               WHERE mm.id_maestro_materia = ?";
                        $stmtHorasActuales = mysqli_prepare($conexion, $queryHorasActuales);
                        mysqli_stmt_bind_param($stmtHorasActuales, 'i', $idMaestroMateria);
                        mysqli_stmt_execute($stmtHorasActuales);
                        mysqli_stmt_bind_result($stmtHorasActuales, $horasImpartidasActuales);
                        mysqli_stmt_fetch($stmtHorasActuales);
                        mysqli_stmt_close($stmtHorasActuales);
            
                        if (!esMaestroDisponible($conexion, $idMaestroMateria, $dia, $horaInicioActual, $horaFinActual, $semanaHorario)) {
                            throw new Exception("El maestro no está disponible en el horario seleccionado.");
                        }
            
                        // Actualizar las horas impartidas solo si es una materia nueva
                        $queryActualizarHoras = "UPDATE Materia SET Horas_impartidas = ? WHERE ID_Materia = (SELECT ID_Materia FROM MaestroMateria WHERE id_maestro_materia = ?)";
                        $stmtActualizarHoras = mysqli_prepare($conexion, $queryActualizarHoras);
                        $nuevasHorasImpartidas = $horasImpartidasActuales + 1;
                        mysqli_stmt_bind_param($stmtActualizarHoras, 'ii', $nuevasHorasImpartidas, $idMaestroMateria);
                        mysqli_stmt_execute($stmtActualizarHoras);
                        mysqli_stmt_close($stmtActualizarHoras);
            
                        // Insertar el detalle del horario
                        $queryDetalle = "INSERT INTO DetalleHorario (ID_Horario, Dia, HoraInicio, HoraFin, ID_MaestroMateria, HoraImpartida) VALUES (?, ?, ?, ?, ?, ?)";
                        $stmtDetalle = mysqli_prepare($conexion, $queryDetalle);
                        mysqli_stmt_bind_param($stmtDetalle, 'isssii', $idHorario, $dia, $horaInicioActual, $horaFinActual, $idMaestroMateria, $nuevasHorasImpartidas);

                        mysqli_stmt_execute($stmtDetalle);
                        mysqli_stmt_close($stmtDetalle);
                    }
                }
            }
        }

        mysqli_commit($conexion);
    } catch (Exception $e) {
        mysqli_rollback($conexion);
        $error = $e->getMessage();
    }

    mysqli_close($conexion);

    // Redirecciona o realiza alguna otra acción después de procesar los datos
    if (isset($error)) {
        header("Location: editar-horario.php?idHorario=" . $idHorario . "&error=" . urlencode($error));
    } else {
        header("Location: Horario-data.php?success=Horario actualizado con ID $idHorario");
    }
    exit();
}

function horasRestantesCero($conexion, $idMaestroMateria) {
    $query = "SELECT horas_impartidas FROM Materia WHERE ID_Materia = (SELECT ID_Materia FROM MaestroMateria WHERE id_maestro_materia = ?)";
    $stmt = mysqli_prepare($conexion, $query);
    mysqli_stmt_bind_param($stmt, 'i', $idMaestroMateria);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $horasRestantes);
    mysqli_stmt_fetch($stmt);
    mysqli_stmt_close($stmt);

    return $horasRestantes < 0;
}
?>
