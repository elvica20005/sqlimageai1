<?php
    $db = mysqli_connect('localhost','root','','base-libros');
    if (!$db) {
        echo "Database connection faild";
    }


    $id=$_POST['id'];
    $name=$_POST['name'];
    $autor=$_POST['autor'];
    $editorial=$_POST['editorial'];
    $image=$_POST['image'];

    $sqlb->query("UPDATE libro SET id='.$id.',name='.$name.',autor='.$autor.',editorial='.$editorial.',image='.$image.' WHERE id='.$id.'");

?>