<?php
session_start();

// Verificar si hay un mensaje de éxito para mostrar
if (isset($_SESSION['mensajeExito'])) {
    $mensajeExito = $_SESSION['mensajeExito'];
    unset($_SESSION['mensajeExito']); // Limpiar el mensaje para evitar que se muestre nuevamente

    // Almacenar el mensaje en una variable JavaScript
    echo '<script>
            var mensajeExito = "' . $mensajeExito . '";
          </script>';
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../Styles/barranav.css">
    <link rel="stylesheet" href="../Styles/tables.css">

    <title>Carrera</title>
</head>
<body>
    <?php
    include("../conector.php");
    ?>
    <!--Menu-->
    <nav class="stroke">
        <ul>
            <li><a href="../Horario-data.php">Horario</a></li>
            <li><a href="../maestros/maestros-data.php">Maestros</a></li>
            <li><a href="../materias/materias-data.php">Materias</a></li>
            <li><a href="../generacion/generacion-data.php">Generacion</a></li> <br> <br>
            <li><a href="../mm/mm-data.php">Cursos Docentes</a></li>
            <li><a href="../incidencias/incidencias-data.php">Incidencias</a></li>
            <li><a href="../actext/actext-data.php">Extras</a></li>
            <li><a href="../grupos/grupos-data.php">Grupos</a></li>
            <li><a class="active" href="../carrera/carrera-data.php">Carrera</a></li>

        </ul>
    </nav>

    <div class="ContenedorAgregar">
        <a href="./carrera.php">
            <button class="buttonnav"><b>Agregar</b></button>
        </a>
    </div>

    <div>
        <table class = "tablita lineasVerticales">
            <tr id="headerTabla">
                <td><b>ID</b></td>
                <td><b>Carrera</b></td>
                <td><b>Acciones</b></td>
            </tr>

            <?php
            $sql="SELECT * from carrera";
            $result=mysqli_query($conexion,$sql);
            $filas=['id_carrera'];
            $idSemestre=$filas;
            while($mostrar=mysqli_fetch_array($result)){
            ?>

            <tr id="datosTabla">
                <td><?php echo $mostrar['id_carrera']?></td>
                <td><?php echo $mostrar['nombre']?></td>
                

                <td id="botonesss">
                    <a href="carrera-edit.php?id=<?php echo $mostrar['id_carrera']?>" <button class="button"><b>Editar</b></button></a>
                    <a href="carrera-delete.php?id=<?php echo $mostrar['id_carrera']?>" <button class="button1"><b>Borrar</b></button></a>
                </td>
            </tr>
            <?php
            }
            ?>
        </table> 
    </div>
            <script src ="confirmacion.js"></script>

            <script>
        document.addEventListener("DOMContentLoaded", function() {
            setTimeout(function() {
                if (typeof mensajeExito !== 'undefined') {
                    alert(mensajeExito);
                }
            }, 300);
        });
    </script>
</body>
</html>