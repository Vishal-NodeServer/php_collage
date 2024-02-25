<?php 
$con = mysqli_connect("localhost","root","","network");
if(!$con){
    echo "Sorry Server is down try next time://";
}
else{
    echo"your Query is Successfully Submited :))";
}

if(isset($_POST['submit'])){
    $fn=$_POST['fn'];
    $pn=$_POST['pn'];
    $Message=$_POST['Message'];

    $sql = "INSERT INTO customer(Name,Mob,Message) VALUES('$fn','$pn','$Message')";
    $a = mysqli_query($con,$sql) or die(mysqli_error());
    echo "<br> data eneter";
}

if(isset($_POST['delete'])){
    $fn=$_POST['fn'];
    $pn=$_POST['pn'];
    $Message=$_POST['Message'];

    $sql="DELETE FROM customer WHERE Name = '$fn'";
    $a = mysqli_query($con,$sql) or die(mysqli_error());
    echo "delete user : $fn" ;



}

if(isset($_POST['update'])){
    $fn = $_POST['fn'];
    $pn = $_POST['pn'];
    $Message = $_POST['Message'];
    $sql="UPDATE customer SET Mob='$pn',Message='$Message' WHERE name = '$fn'";
     $a = mysqli_query($con,$sql) or die(mysqli_error());
     echo "<br>updtae $fn";
}

if(isset($_POST['search'])){
    $fn = $_POST['fn'];
    $pn = $_POST['pn'];
    $Message = $_POST['Message'];

    $sql ="SELECT * from customer WHERE Name = '$fn'";
    $res = mysqli_query($con,$sql) or die(mysqli_error());
    echo "Data found......";

    $table = mysqli_query($con,$sql);
      echo "<table border='1'>
      <tr>
          <td>Name : </td>
          <td>Mobie No : </td>
          <td>Message : </td>
      
      
      </tr>";

      while($row=mysqli_fetch_array($table)){
        echo "<tr>";
        echo "<td>",$row['Name'],"</td>";
        echo "<td>",$row['Mob'],"</td>";
        echo"<td>",$row['Message'],"</td>";
        echo "</tr>";
      }
      echo "</table>";
}

?>
