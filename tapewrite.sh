#!/bin/bash
baudrate=$1
tmpcomp="/tmp/comp.tar.lzma"
tmp="/tmp/data.tmp"
con=0
if [[ "$#" -eq 0 ]];then
	echo "Uso: tapewrite [Baudios] [Archivo o carpeta] -c"
	echo "	   -c : Habilita la compresión (para backups de directorios)."
	exit 0
else
	if [[ "$baudrate" > 4500 ]];then
		echo "Valor de baudios máximo óptimo es 4500."
		exit 0
	else
		if [ -f "$2" ] || [ -d "$2" ];then
			if [[ "$3" = "-c" ]]; then
				#Compresión
				tar --lzma -cvf $tmpcomp $2
			fi
			#Marca de inicio
			printf "," >> $tmp
			#Calibración
			while [ $con -lt 20 ]
			do
				printf "PNNN" >> $tmp
				let con++
			done
			#Inicio de datos
			printf "@" >> $tmp
			if [[ "$3" = "-c" ]]; then
				echo "comp.tar.lzma" >> $tmp
				cat "$tmpcomp" | base64 >> $tmp		
				rm $tmpcomp
			else
				echo "$2" >> $tmp
				cat "$2" | base64 >> $tmp
				cat "$2" >> $tmp		
			fi
			echo "," >> $tmp
			cat $tmp | minimodem -t $baudrate -v 0.1 -A -f out.wav
			rm $tmp		
		else
			echo "No se encuentra el archivo."
			exit 0
		fi
	fi
fi
