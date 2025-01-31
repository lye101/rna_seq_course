#!/bin/bash

#SBATCH --array=1-16
#SBATCH --time=01:00:00
#SBATCH --mem=1000MB
#SBATCH --cpus-per-task=1
#SBATCH --job-name=fastQC_array
#SBATCH --partition=pibu_el8
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ltucker/rna_seq_course/log/fastqc_%j.out
#SBATCH --error=/data/users/ltucker/rna_seq_course/log/fastqc_%j.err

# Define Variable Directories
WORKDIR="/data/users/ltucker/rna_seq_course"
OUTDIR="$WORKDIR/fastqc_results"
SAMPLELIST="$WORKDIR/samplelist.tsv"
LOGDIR="$WORKDIR/log"

# make directories if they don't exist
mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"

# Pull specific forward and reverse reads 
SAMPLE=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line{print $1; exit}' $SAMPLELIST`
READ1=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line{print $2; exit}' $SAMPLELIST`
READ2=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line{print $3; exit}' $SAMPLELIST`

# run fastQC for each paired-end read (forward and reverse)
apptainer exec --bind /data /containers/apptainer/fastqc-0.12.1.sif fastqc --outdir="$OUTDIR" "$READ1" "$READ2"
