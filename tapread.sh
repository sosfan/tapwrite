#!/bin/bash
#Uso tapread nombre_salida
baudrate=4000
tmp="/tmp/data.tmp"
echo "Escuchando datos..."
echo "Use Ctrl + C para detener la operación."
minimodem --rx-one $baudrate -q > $tmp 
if [[ $# -eq 0 ]];then
	namefile=`cat $tmp | cut -d "@" -f 2 -s`
	cat $tmp | cut -d "," -f 1 | base64 -d > "$namefile"
else
	cat $tmp | cut -d "," -f 1 | base64 -d > "$1"
fi
rm $tmp
