#!/bin/bash
#Uso tapwrite nombre_entrada
baudrate=4000
tmp="/tmp/data.tmp"
con=0
if [[ "$#" -eq 0 ]];then
	echo "Uso: tapwrite [nombre de archivo]"
else
	if [ -f "$1" ];then
		printf "," >> $tmp
		while [ $con -lt 20 ]
		do
			printf "PNNN" >> $tmp
			let con=con+1
		done
		printf "@" >> $tmp
		echo "$1" >> $tmp
		cat "$1" | base64 >> $tmp		
		echo "," >> $tmp
		cat $tmp | minimodem -t $baudrate -v 0.1 -f out.wav
		rm $tmp
	else
		echo "No existe el archivo de entrada."
	fi
fi
