<?php/*Countdonw for close session, Version 1.14.0 */ ?>  

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">

    <title></title>
</head>
<body>

<div id="number"></div>
    </div>
    <script >
        count = 900
        var l = document.getElementById("number");
        var id = window.setInterval(function() {
            document.onmousemove = function() {
                count = 900;
            }; 
            l.innerText = count;
            count--;
            if (count <= 0){
			location.href = "../../close_session.php";
            }
        }, 1200);

        
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
   

</body>

</html>


