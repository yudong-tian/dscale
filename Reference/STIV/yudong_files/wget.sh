#!/bin/bash
ls abc00asd
while [ $? -ne 0 ]; do 
sleep 15
wget --passive-ftp -T 60 -c -nd -m -np ftp://128.117.150.211/pub/download/codiac/yudon2379/

done
