<?php

$db = mysqli_connect('localhost','root','','base-libros');
if (!$db) {
    echo "Database connection faild";
}
    
    $id = $_POST['id'];
    
    $sql = "DELETE FROM libro WHERE id='$id'";
    $query = $mysqli->query($sql);
    
?>
