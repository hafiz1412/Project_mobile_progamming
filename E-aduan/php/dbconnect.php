<?php
$servername = "localhost";
$username   = "shababit_e_aduan_final";//kena ubah
$password   = "eaduanfinal";//kena ubah
$dbname     = "shababit_e_aduan_final";//kena ubah

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>