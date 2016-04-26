#! /usr/bin/env bash

#BSUB -J align[1-8]
#BSUB -e logs/align.%I.%J.err
#BSUB -o logs/align.%I.%J.out
#BSUB -R "span[hosts=1]"
#BSUB -n 12

set -exo pipefail

FQDIR=data
picard=/vol1/software/modules-sw/Picard/build/picard-tools-1.83/
# REF=/vol3/home/jhessel/ref/genomes/hg19/hg19.fa
REF=GRCh37/genome.fa

samples=(ll-1 ll-3 ll-5 ll-7 lll-10 lll-1 lll-2 lll-9)
sample=${samples[$(($LSB_JOBINDEX - 1))]}

R1=$FQDIR/${sample}_R1_001.fastq.gz
R2=$FQDIR/${sample}_R2_001.fastq.gz

##########
# FASTQC #
##########

mkdir -p exome-qc/$sample

# run only on 2nd read
# fastqc -o exome-qc/$sample/ $R2

#############
# Alignment #
#############

mkdir -p results/

bwa mem -R '@RG\tID:'$sample'\tSM:'$sample \
    -M -U 40 $REF $R1 $R2 -t 12 \
    | samtools view -bS - \
    | samtools sort - results/$sample

samtools index results/$sample.bam

################################
# Mark/Remove (PCR) Duplicates #
################################

java -Xmx4g -jar $picard/MarkDuplicates.jar \
    I=results/$sample.bam \
    O=results/$sample.dedup.bam \
    M=results/$sample.dedup.metrics.txt \
    ASSUME_SORTED=true

samtools index results/$sample.dedup.bam
