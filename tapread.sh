#!/bin/bash
#Uso tapread nombre_salida
baudrate=4000
tmp="/tmp/data.tmp"
echo "Escuchando datos..."
echo "Use Ctrl + C para detener la operación."
#Use ésta opción para escuchar la señal análoga mediante el auxiliar.
#minimodem --rx $baudrate -q -a -8 > $tmp
#Use ésta opción para escuchar mediante el monitor del sistema.
minimodem --rx-one $baudrate -q -a -8 > $tmp 
if [[ $# -eq 0 ]];then
	namefile=`cat $tmp | cut -d "@" -f 2 -s`
	cat $tmp | cut -d "," -f 1 | base64 -d -i > "$namefile"
else
	cat $tmp | cut -d "," -f 1 | base64 -d -i > "$1"
fi
rm $tmp
