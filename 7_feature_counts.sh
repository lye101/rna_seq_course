#!/bin/bash

#SBATCH --time=02:00:00
#SBATCH --mem=1000MB
#SBATCH --cpus-per-task=4
#SBATCH --job-name=sort-index
#SBATCH --partition=pibu_el8
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ltucker/rna_seq_course/log/featurecount_%A_.out
#SBATCH --error=/data/users/ltucker/rna_seq_course/log/featurecount_%A.err

# Define directory variables
WORKDIR="/data/users/ltucker/rna_seq_course"
OUTDIR="$WORKDIR/feature_counts"

# Make directory variables if not created
mkdir -p $OUTDIR

# get all sorted bam files
cd $WORKDIR/mapping
bam_files=`ls *_sorted.bam`

# run feature counts with quality 10 2nd strand as reverse
apptainer exec --bind /data /containers/apptainer/subread_2.0.1--hed695b0_0.sif \
    featureCounts -T4 -p -s2 -Q10 -t exon -g gene_id -a "$WORKDIR/Mus_musculus.GRCm39.113.gtf" \
    -o "$OUTDIR/gene_counts.txt" $bam_files 