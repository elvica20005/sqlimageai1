<?php

    $db = mysqli_connect('localhost','root','','base-libros');
    if (!$db) {
        echo "Database connection faild";
    }

    $libro = $db->query("SELECT * FROM libro");
    $list = array();

    while ($rowdata= $libro->fetch_assoc()) {
        $list[] = $rowdata;
    }

    echo json_encode($list);