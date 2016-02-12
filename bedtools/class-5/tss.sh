#! /usr/bin/env bash

genes="genes.hg19.bed.gz"

gzcat $genes | awk 'BEGIN {OFS="\t"} ($6 == "+") \
    {print $1, $2, $2 + 1, $4, $5, $6 }' > tss.bed

gzcat $genes | awk 'BEGIN {OFS="\t"} ($6 == "-") \
    {print $1, $3, $3 + 1, $4, $5, $6 }' >> tss.bed

bedtools sort -i tss.bed > tmp.bed
mv tmp.bed tss.bed
