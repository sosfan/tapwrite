#!/bin/bash
#Uso: taperead [Baudios]
baudrate=$1
tmp="/tmp/data.tmp"
if [[ $1 -eq 0 ]];then
	echo "Uso: taperead [Baudios]"
	exit 0
fi
echo "Escuchando datos..."
echo "Use Ctrl + C para detener la operación."
minimodem --rx-one $baudrate -q > $tmp 
#if [[ $2 -eq 0 ]];then
	namefile=`cat $tmp | cut -d "@" -f 2 -s`
	cat $tmp | sed '1d' | sed '$d' | base64 -d > "$namefile"
	if [[ $namefile = "comp.tar.lzma" ]];then
		tar --lzma -xvf $namefile
		rm $namefile
	fi
#else
#	cat $tmp | cut -d "," -f 1 | base64 -d > "$2"
#fi
rm $tmp
