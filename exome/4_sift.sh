
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	ll-1	ll-3	ll-5	ll-7	lll-1	lll-10	lll-2	lll-9

cat  results/vcfs/*.snpeff.dbsnp.vcf | \
java -Xmx4G -jar snpEff/SnpSift.jar \
    filter  \
    "((QUAL >= 40) & isVariant(GEN[0]) & isVariant(GEN[3]) \
    & isVariant(GEN[4]) & isVariant(GEN[7]) & isVariant(GEN[5]) \
    & isRef(GEN[1]) & isRef(GEN[2]) & isRef(GEN[6]) \
    & (DP >= 40) \
    & (( na FILTER) | (FILTER = 'PASS')) \
    & ((EFF[*].IMPACT = 'HIGH') | (EFF[*].IMPACT = 'MODERATE'))
        )" 

