# tapewrite
tapewrite/taperead - Utilidad para escribir/leer datos en cassettes de audio.
Requiere: minimodem https://github.com/kamalmostafa/minimodem

Para generar un archivo wav de su archivo.

./tapewrite.sh [Baudios] [Archivo o carpeta] -c

  -c: Habilita la compresión .tar.lzma

Para leer su archivo de un flujo de audio. (monitor o entrada de linea)

./taperead.sh [Baudios]

