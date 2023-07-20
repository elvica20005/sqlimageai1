<?php

$db = mysqli_connect('localhost','root','','base-libros');
if (!$db) {
    echo "Database connection faild";
}
    
    // PRUEBAS
    //$usuario = "cheko";
    
    $sql = "SELECT * FROM libro";
    $query = $mysqli->query($sql);
    
    $datos = array();
    
    while($resultado = $query->fetch_assoc()) {
        $datos[] = $resultado;
    }
    
    echo json_encode($datos);
    //echo json_encode(array("usuarios" => $datos));
?>
