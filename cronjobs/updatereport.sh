#!/bin/bash

# Ingresar a ruta de copia de archivos

cd /var/www/html/livehelperchat-master/lhc_web/auditreportcopies/


# El nombre del archivo original

file="lh_audit_user_changes.csv" 
fecha_actual=$(date +"%Y-%m-%d %H:%M:%S") 
# Contador para agregar un número al nombre de cada copia
count=1

# Bucle que crea y renombra las copias
for i in {0}; do
# Crea una copia del archivo original
cp "$file" "${file%.}_$count.${fecha_actual##.}"
# Incrementa el contador
  count=$((count + 1))
done


ls 

# Eliminar archivo original
rm lh_audit_user_changes.csv

# Nombre de la base de datos
DB_NAME="livechat";
# Usuario y contraseña de MySQL
MYSQL_USER="root";
MYSQL_PASSWORD="master";

# Extracción de información de la tabla
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME -e "SELECT * FROM lh_audit_user_changes INTO OUTFILE '/var/www/html/livehelperchat-master/lhc_web/auditreportcopies/lh_audit_user_changes.csv'FIELDS TERMINATED BY ';'OPTIONALLY ENCLOSED BY '\"'LINES TERMINATED BY'\r\n';";

# Eliminar la tabla
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME -e "DROP TABLE IF EXISTS ip_prueba;";
# Eliminar la tabla
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME -e "DROP TABLE IF EXISTS lh_audit_user_changes;";

# crear la tabla
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME << EOF
CREATE TABLE ip_prueba (
   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   ip VARCHAR(255) NOT NULL,
   user_id VARCHAR(255) NOT NULL,
   date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP NOT NULL
);
EOF

# crear la tabla
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME << EOF
CREATE TABLE lh_audit_user_changes (
   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   LOG_CHANGES VARCHAR(1000) NOT NULL
);
EOF

# Eliminar la trigger
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME -e "DROP TRIGGER IF EXISTS log_user;";


# Crear la trigger
mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $DB_NAME << EOF

DELIMITER $$
CREATE TRIGGER log_user
AFTER UPDATE  ON lh_users
FOR EACH ROW
BEGIN
INSERT INTO lh_audit_user_changes (LOG_CHANGES)
VALUES (concat ('registro actualizado : \n\r\nafter_id: ',
old.id,
'\r\nafter_username: ',
old.username,
'\r\nafter_name: ',
old.name,
'\r\nafter_surname: ',
old.surname,
'\r\nafter_nickname: ',
old.chat_nickname,
'\r\nafterdepartments: ',
old.departments_ids,
'\r\nafter_job_title: ',
old.job_title,
'\r\nafter_disabled: ',
old.disabled,
'\r\nafter_hide_online: ',
old.hide_online,
'\r\nafter_automatic_assignment: ',
old.auto_accept,
'\r\nafter_inactive_mode: ',
old.inactive_mode,
'\r\nafter_exclude_autoasing: ',
old.exclude_autoasign,
'\r\nafter_max_active_chats: ',
old.max_active_chats,
'\r\nnewid: ',
new.id,                                     
'\r\nnew_name: ',
new.name,
'\r\nnew_username: ',
new.username,
'\r\nnew_surname: ',
new.surname,
'\r\nnew_nickname: ',
new.chat_nickname,
'\r\nnew.departments_ids: ',
new.departments_ids,
'\r\nnew.job_title: ',
new.job_title,
'\r\nnew.disabled: ',
new.disabled,
'\r\nnew.hide_online: ',
new.hide_online,
'\r\nnew.inactive_mode: ',
new.inactive_mode,
'\r\nnew.auto_accept: ',
new.auto_accept,
'\r\nnew.exclude_autoasign: ',
 new.exclude_autoasign,
'\r\nnew_max_active_chats: ',
new.max_active_chats));
END;
$$
DELIMITER ;
EOF

# Reinicio del motor
systemctl restart mariadb

echo "Actualización de tablas de reporte completa";


