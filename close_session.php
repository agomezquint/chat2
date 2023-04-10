<?php
/*
Countdonw for close session from time_session,.tpl.php
Version 1.14.0
 */ 


 //logout session   
 session_start();
 if(isset($_SESSION['lhc_user_id'])){
   session_unset();
   session_destroy();  
    header("Location:index.php/site_admin/user/login");
 }else {
    //no exist session
    session_unset();
   session_destroy();  
    header("Location:index.php/site_admin/user/login");
 }

 ?>  

 
   