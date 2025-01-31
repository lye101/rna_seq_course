#!/bin/bash

FASTQ_FOLDER=$1 # Call folder with raw reads from command line

# Create a list of FastQ files for each read
for FILE in $FASTQ_FOLDER/*_*1.fastq.gz 
do 
    PREFIX="${FILE%_*.fastq.gz}"
    SAMPLE=`basename $PREFIX`
    echo -e "${SAMPLE}\t$FILE\t${FILE%?.fastq.gz}2.fastq.gz"
done


