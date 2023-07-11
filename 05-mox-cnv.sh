#!/bin/bash
## Job Name
#SBATCH --job-name=cnv
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-00:00:00
## Memory per node
#SBATCH --mem=100G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sr320@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/sr320/071123-cnv


# the following were all done at terminal
#grab genome
#curl -O https://gannet.fish.washington.edu/panopea/Cg-roslin/cgigas_uk_roslin_v1_genomic-mito.fa

# sequence reads
# wget -r \
# --no-directories --no-parent \
# -P . \
# -A "F*gz" \
# http://owl.fish.washington.edu/nightingales/C_gigas/


# index genome

/gscratch/srlab/programs/bowtie2-2.4.2-linux-x86_64/bowtie2-build \
cgigas_uk_roslin_v1_genomic-mito.fa \
cgigas_uk_roslin_v1_genomic-mito.index



find *_R1_001_fastq.gz | xargs basename -s _R1_001_fastq.gz \
| xargs -I{} /Applications/bioinfo/bowtie2-2.2.4/bowtie2 \
-x cgigas_uk_roslin_v1_genomic-mito.index \
-1 {}_R1_001_fastq.gz \
-2 {}_R2_001_fastq.gz \
-p 40 \
-S {}.sam



find *.sam | \
xargs basename -s .sam | \
xargs -I{} /gscratch/srlab/programs/samtools-1.9/ \
sort --threads 28 {}.bam \
-o {}.sorted.bam

samtools view -bS alignment.sam | samtools sort -o sorted_alignment.bam


/gscratch/srlab/programs/samtools-1.9/samtools merge \
Pg_merged.bam \
*.sorted.bam


perl /gscratch/srlab/programs/BS-Snper-master/BS-Snper.pl \
Pg_merged.bam \
--fa Panopea-generosa-v1.0.fa \
--output snp.candidate.out \
--methcg meth.cg \
--methchg meth.chg \
--methchh meth.chh \
--minhetfreq 0.1 \
--minhomfreq 0.85 \
--minquali 15 \
--mincover 10 \
--maxcover 1000 \
--minread2 2 \
--errorate 0.02 \
--mapvalue 20 \
>SNP.vcf 2>SNP.log