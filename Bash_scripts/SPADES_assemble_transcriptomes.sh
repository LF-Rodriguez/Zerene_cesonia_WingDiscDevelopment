## -------------------
## Description
## -------------------

# Do de novo assembly of individual libraries, 
# one per biological condition using SPADES with K-mer 
# sizes 21,25,75,81 and default.

## ---------------------
## Set up
## ---------------------

WORK_DIR=/home/lfern/projects/Zerene2018/spades
DATA_DIR=/home/lfern/projects/Zerene2018/reads_by_stage
SOFT_DIR=/home/lfern/software/SPAdes-3.10.1-Linux/bin
SEQT_DIR=/home/lfern/software/seqtk

## -------------------------------
## Sample 10M reads per condition
## -------------------------------

cd $DATA_DIR

for folder in $(ls); do
	
	cat $folder/*R1*fq.gz > $WORK_DIR/$folder/all_R1.fq.gz
	cat $folder/*R2*fq.gz > $WORK_DIR/$folder/all_R2.fq.gz

	$SEQT_DIR/seqtk sample -s 11 $WORK_DIR/$folder/all_R1.fq.gz 10000 > $WORK_DIR/$folder/R1.fq.gz
	$SEQT_DIR/seqtk sample -s 11 $WORK_DIR/$folder/all_R2.fq.gz 10000 > $WORK_DIR/$folder/R2.fq.gz

	for n in 21 25 75 81; do

		python2 rnaspades.py -o $WORK_DIR/$folder/'K'$n \
							 -1 $WORK_DIR/$folder/R1.fq.gz \
							 -2 $WORK_DIR/$folder/R2.fq.gz \
							 --only-assembler \
							 --threads 20 \
							 -k $n
	done

	python2 rnaspades.py -o $WORK_DIR/$folder/'K_default \
							 -1 $WORK_DIR/$folder/R1.fq.gz \
							 -2 $WORK_DIR/$folder/R2.fq.gz \
							 --only-assembler \
							 --threads 20

done



