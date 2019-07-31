#!/bin/bash

EXTENSIONS="pdf"
BKP=./pdf_original
ORI=./pdf_compressed
FIG=./fig

for entry in ./*
do
 if [ -d "$entry" ];then	#condition with -d is true if the file is a directory
  echo "$entry"
  cd "$entry"
      for FILE in ./*.$EXTENSIONS
      do
      if [ $(head -c 4 $FILE) = "%PDF" ]; then
         ps2pdf $FILE $ORI/$FILE
         mv $FILE $BKP/$FILE
      fi
      done
      #rm ./*.fig
      mv ./*.fig $FIG
  cd ..
 fi
 done
