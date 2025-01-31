#!/bin/bash

#SBATCH --array=1-16
#SBATCH --time=02:00:00
#SBATCH --mem=1g
#SBATCH --cpus-per-task=4
#SBATCH --partition=pibu_el8
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ltucker/rna_seq_course/log/mapping_%j.out
#SBATCH --error=/data/users/ltucker/rna_seq_course/log/mapping_%j.err

# define variables
WORKDIR="/data/users/ltucker/rna_seq_course"
OUTDIR="$WORKDIR/mapping"
SAMPLELIST="$WORKDIR/samplelist.tsv"

# New directories
mkdir -p "$OUTDIR"

SAMPLE=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line{print $1; exit}' $SAMPLELIST`
READ1=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line{print $2; exit}' $SAMPLELIST`
READ2=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line{print $3; exit}' $SAMPLELIST`
echo "$READ1 $READ2"

# Create indexes for Genome before mapping
apptainer exec --bind /data /containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif hisat2 \
    -x /data/users/ltucker/rna_seq_course/genome_indexes/genome_index \
    -1 "$READ1" -2 "$READ2" --rna-strandness RF -S "$OUTDIR/${SAMPLE}_aligned_sample.sam"

# Convert SAM to BAM using samtools
apptainer exec --bind /data /containers/apptainer/samtools-1.19.sif samtools view -bS "$OUTDIR/${SAMPLE}_aligned_sample.sam" > "$OUTDIR/${SAMPLE}_aligned_sample.bam"

# Remove Sam files to no use space
rm "$OUTDIR/${SAMPLE}_aligned_sample.sam"