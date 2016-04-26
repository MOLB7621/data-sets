#! /usr/bin/env bash

#BSUB -J freebayes[1-22]
#BSUB -e logs/freebayes.%I.%J.err
#BSUB -o logs/freebayes.%I.%J.out

set -ex

# REF=/vol3/home/jhessel/ref/genomes/hg19/hg19.fa
REF=GRCh37/genome.fa

# chroms are 
chrom=$LSB_JOBINDEX

mkdir -p results/vcfs/

freebayes --region $chrom \
    --fasta-reference \
    $REF results/*dedup.bam \
    > results/vcfs/$chrom.vcf
