
<?php include 'con.php'; ?>

<table class =  "table  table-striped">
        <thead>
        <tr>
            <th width="1%">id</th>
            <th width="0.5%">fecha del cambio</th>
            <th width="1%">ip</th>
            <th width="1%">usuario</th>
            <th width="0.5%">Log</th>
        <tr>    
        </thead>

        <?php foreach($con->query("SELECT * FROM ip_prueba p INNER JOIN lh_audit_user_changes i ON i.id = p.id") as  $row){?>
        <tr>
            <td><?php echo $row ["id"]?></td>
            <td><?php echo $row ["date"]?></td>
            <td><?php echo $row ["ip"]?></td>
            <td><?php echo $row ["user_id"]?></td>
            <td><?php echo $row ["LOG_CHANGES"]?></td>
        </tr>
        <?php } ?>
        </table>



    