#!/bin/bash

echo "Ejecutando tareas..."
rm -rvf /var/www/html/livehelperchat-master/lhc_web/cache/cacheconfig/*
rm -rvf /var/www/html/livehelperchat-master/lhc_web/cache/compiledtemplates/*
sync; echo 3 > /proc/sys/vm/drop_caches
service nginx restart
echo "Proceso terminado"

