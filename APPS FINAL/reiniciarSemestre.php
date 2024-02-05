<?php
include("conector.php");
session_start();

// Reiniciar las horas impartidas
$query = "UPDATE Materia SET Horas_impartidas = 0";
if (mysqli_query($conexion, $query)) {
    $_SESSION['mensajeExito'] = "Las horas han sido reiniciadas para el nuevo semestre.";
} else {
    $_SESSION['mensajeExito'] = "Error al reiniciar las horas: " . mysqli_error($conexion);
}

// Redirigir de vuelta a la página principal
header('Location: ./materias/materias-data.php');
exit();
?>
