region=12:12022035-12023035
region=6:30953708-30955708

set -ex -o pipefail

BAMDIR=~/public_html/exome-region/
mkdir -p $BAMDIR

rm -f $BAMDIR/info-muc21.bed

for f in results/*.dedup.bam; do
    sample=$(basename $f .dedup.bam)
    samtools view -h $f $region \
        | awk 'BEGIN{FS=OFS="\\t"} $0 ~/^@/{ print $0 }   $0 !~ /^@/ { print "chr"$0 }' \
        | samtools view -bS - > $BAMDIR/$sample-muc21.bam
    samtools index $BAMDIR/$sample-muc21.bam
    echo "track type=bam name=$sample bigDataUrl=http://amc-sandbox.ucdenver.edu/~brentp/exome-region/$sample-muc21.bam visibility=2" >> $BAMDIR/info-muc21.bed
done
