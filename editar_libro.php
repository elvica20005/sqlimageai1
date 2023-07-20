<?php

$db = mysqli_connect('localhost','root','','base-libros');
if (!$db) {
    echo "Database connection faild";
}

    $id = $_POST['id'];
    $name = $_POST['name'];
    $autor = $_POST['autor'];
    $editorial = $_POST['editorial'];
    
    /*$idUsuario = "27";
    $nombre = "sergio";
    $telefono = "123456";
    $email = "sergio";*/

    $sql = "UPDATE libro SET name='$name', autor='$autor', editorial='$editorial' WHERE id='$id'";
    
    $query = $mysqli->query($sql);

?>
