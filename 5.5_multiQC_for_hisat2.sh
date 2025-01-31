#!/bin/bash

#SBATCH --job-name=multiqc
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --partition=pibu_el8
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ltucker/rna_seq_course/log/multiqc_on_fastqc_%j.out
#SBATCH --error=/data/users/ltucker/rna_seq_course/log/multiqc_on_fastqc_%j.err

# directory vatiables 
WORKDIR="/data/users/ltucker/rna_seq_course"
OUTDIR="$WORKDIR/multiqc_for_hsat2_mapping_results"

# create non-existing directories
mkdir -p $OUTDIR

# run multiQC using fastqc outputs
apptainer exec --bind /data /containers/apptainer/multiqc-1.19.sif \
    multiqc -o "$OUTDIR" "$WORKDIR/hisat2_outputs_anki/"


