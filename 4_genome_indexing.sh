#!/bin/bash

#SBATCH --time=03:00:00
#SBATCH --mem=8000MB
#SBATCH --cpus-per-task=1
#SBATCH --job-name=slurm_array
#SBATCH --partition=pibu_el8
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ltucker/rna_seq_course/log/mapping_%j.out
#SBATCH --error=/data/users/ltucker/rna_seq_course/log/mapping_%j.err

# define variables
WORKDIR="/data/users/ltucker/rna_seq_course"
OUTDIR="$WORKDIR/genome_indexes"
SAMPLELIST="$WORKDIR/samplelist.tsv"

# make new directories
mkdir -p "$OUTDIR"

# Make genome index using hisat2-samtools
apptainer exec --bind /data /containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif hisat2-build \
    -p16 /data/users/ltucker/rna_seq_course/Mus_musculus.GRCm39.dna.primary_assembly.fa "$OUTDIR/genome_index"

