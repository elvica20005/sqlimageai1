<?php
    $db = mysqli_connect('localhost','root','','base-libros');
    if (!$db) {
        echo "Database connection faild";
    }

    $autor = $_POST['autor'];
    $editorial = $_POST['editorial'];
    $image = $_FILES['image']['name'];
    $name = $_POST['name'];

    $imagePath = 'uploads/'.$image;
    $tmp_name = $_FILES['image']['tmp_name'];

    move_uploaded_file($tmp_name, $imagePath);

    $db->query("INSERT INTO libro(name,autor,editorial,image)VALUES('".$name."','".$autor."','".$editorial."','".$image."')");

?>