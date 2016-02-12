#! /usr/bin/env bash

tss_bed="tss.bed"
signal="../ctcf.hela.chr22.bg.gz"
genome="../hg19.genome"

bedtools slop -i $tss_bed -b 1000 -g $genome \
    | bedtools makewindows -b - -n 40 -i winnum \
    | bedtools sort -i - \
    | bedtools map -a - -b $signal -c 4 -o mean \
    | awk '$5 != "."' \
    | sort -k4n \
    | bedtools groupby -g 4 -c 5 -o sum \
    > signal.tab
