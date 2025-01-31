#!/bin/bash

#SBATCH --array=1-16
#SBATCH --time=02:00:00
#SBATCH --mem=25000MB
#SBATCH --cpus-per-task=6
#SBATCH --job-name=sort-index
#SBATCH --partition=pibu_el8
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ltucker/rna_seq_course/log/bam_sort_index_%A_.out
#SBATCH --error=/data/users/ltucker/rna_seq_course/log/bam_sort_index_%A.err

# Define directory variables
WORKDIR="/data/users/ltucker/rna_seq_course"
OUTDIR="$WORKDIR/mapping"

# Read the BAM file and correspind it to an array task
cd $WORKDIR/mapping
ls *.bam > $WORKDIR/bam_list.txt
bam_file=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $WORKDIR/bam_list.txt)

# Define the output sorted file name
sorted_file="$OUTDIR/${bam_file%.bam}_sorted.bam"

# Sort the BAM file
apptainer exec --bind /data /containers/apptainer/samtools-1.19.sif \
    samtools sort -@ $SLURM_CPUS_PER_TASK -o "$sorted_file" "$bam_file"

# Index the sorted BAM file
apptainer exec --bind /data /containers/apptainer/samtools-1.19.sif \
    samtools index "$sorted_file"
