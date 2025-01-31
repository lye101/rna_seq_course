#!/bin/bash

#SBATCH --mail-type=done
#SBATCH --job-name="fastqc_for_rna_seq_course"
#SBATCH --cpus-per-task=12
#SBATCH --time=00:20:00
#SBATCH --mem=32G
#SBATCH --ntasks=1
#SBATCH --partition=pshort_el8

module load MultiQC/1.11-foss-2021a

WORKDIR="/data/users/ltucker"
FASTQCDIR="$WORKDIR/reads"

multiqc $FASTQCDIR/*_fastqc.zip --outdir /data/users/mjacquey/RNA_seq_project/multiQC_result