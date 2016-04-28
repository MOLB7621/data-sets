#! /usr/bin/env bash

#BSUB -J exp_regev
#BSUB -o %J.%I.out
#BSUB -e %J.%I.err
#BSUB -n 12

data=$HOME/projects/5OH/data/methodspaper/sacCer1/expression/regev

# Regev RNA-seq data
sample=SRR059177
fastq="$data/$sample.fastq.gz"

threads=1
bwtindex=$HOME/ref/genomes/sacCer1/sacCer1
gtf=$HOME/ref/genomes/sacCer1/sgdGene.sacCer1.gtf
bam=$sample.bam
posbg=$sample.pos.bg
negbg=$sample.neg.bg

bowtie2 -3 100 -U $fastq -x $bwtindex -p $threads \
    | samtools view -ShuF4 - \
    | samtools sort -o - $sample.temp -m 2G \
    > $bam

bedtools genomecov -ibam $bam -split -bg -strand + > $posbg
bedtools genomecov -ibam $bam -split -bg -strand - > $negbg

cufflinks --library-type fr-firststrand -G $gtf -p $threads $bam
