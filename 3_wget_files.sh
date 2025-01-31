# get reference genome and primary assembly for mapping reads onto genome

# Get reference genome
wget https://ftp.ensembl.org/pub/current_gtf/mus_musculus/Mus_musculus.GRCm39.113.gtf.gz

# Get primary assembly
wget https://ftp.ensembl.org/pub/release-113/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz

# Compare expected sums and actual sums for the primary assembly file 
wget https://ftp.ensembl.org/pub/release-113/fasta/mus_musculus/dna/CHECKSUMS -nc

my_sum=`sum Mus_musculus.GRCm39.dna.primary_assembly.fa.gz`
expected_sum=`awk '/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz/ {print $1, $2}' CHECKSUMS`

echo "
My fasta Mus musculus fasta sums (Mus_musculus.GRCm39.dna.primary_assembly.fa)
has sum $my_sum and the expected sum is $expected_sum
"

# unzip files
gunzip Mus_musculus.GRCm39.113.gtf.gz
gunzip Mus_musculus.GRCm39.dna.primary_assembly.fa.gz