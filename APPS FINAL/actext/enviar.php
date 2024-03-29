<?php
include("../conector.php");

if (isset($_POST['enviar1'])) {
    try {
        // Validación del campo actext
        if (!(strlen($_POST['actext']) >= 1)) {
            throw new Exception("¡Por favor complete los campos!");
        }

        // Limpieza y obtención de valores
        $nombre = mysqli_real_escape_string($conexion, trim($_POST['actext']));
       

        // Inserción en la base de datos
        $consulta = "INSERT INTO `actext`(`nombre_act`) VALUES ('$nombre')";
        $resultado = mysqli_query($conexion, $consulta);

        if (!$resultado) {
            throw new Exception("¡Ha ocurrido un error en su registro!");
        }

        // Mensaje de éxito
        $mensajeExito = "¡Su registro fue exitoso!";

        // Redirección al usuario después de la inserción exitosa
        echo "<script>alert('$mensajeExito');</script>";
        header("Location: actext-data.php");
        exit();

    } catch (Exception $e) {
        // Mensaje de error
        echo "<script>alert('{$e->getMessage()}');</script>";
    }
}

// Cerrar la conexión a la base de datos
mysqli_close($conexion);
?>
