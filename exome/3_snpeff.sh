#! /usr/bin/env bash

#BSUB -J snpeff[1-22]
#BSUB -e logs/snpeff.%I.%J.err
#BSUB -o logs/snpeff.%I.%J.out
#BSUB -R "span[hosts=1]"
#BSUB -n 1

# from snpEff dir
#module load java/1.7
#java -jar snpEff.jar download GRCh37.69
# wget -O dbSnp.vcf.gz ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606/VCF/00-All.vcf.gz
#gunzip dbSnp.vcf.gz


set -ex
chrom=$LSB_JOBINDEX

java -Xmx4G -jar snpEff/snpEff.jar \
    -c snpEff/snpEff.config GRCh37.69 \
    results/vcfs/$chrom.vcf \
    > results/vcfs/$chrom.snpeff.vcf

java -Xmx4G -jar snpEff/SnpSift.jar \
    annotate dbSnp.vcf \
    results/vcfs/$chrom.snpeff.vcf \
    > results/vcfs/$chrom.snpeff.dbsnp.vcf

