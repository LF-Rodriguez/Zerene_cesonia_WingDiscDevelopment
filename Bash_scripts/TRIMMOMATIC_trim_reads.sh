## -------------------
## Description
## -------------------

# Uses Trimmomatic to trim reads and filter 
# low quality reads.

## ---------------------
## Set up
## ---------------------

DATA_DIR=/home/lfern/projects/Zerene2018/corrected_reads
WORK_DIR=/home/lfern/projects/Zerene2018/trimmed_reads
SOFT_DIR=/home/lfern/software/trimmomatic-0.36

## ---------------------------------
## Run Trimmomatic in all libraries
## ----------------------------------

cd $DATA_DIR

for left in $(ls *_R1_*); do
	
	right=$(echo $left | sed 's/_R1_/_R2_/g')
	base=$(echo $left | cut -f1 -d'_')

	java-jar trimmomatic-0.36.jar PE\
								  -threads 8 \
								  $left $right \
								  -baseout $WORK_DIR/$base \
								  ILLUMINACLIP:Polix.fa:2:15:10 \
								  ILLUMINACLIP:NexteraPE-PE_ZC2018:2:25:10 \
								  LEADING:4 \
								  TRAILING:4 \
								  SLIDINGWINDOW:4:26
								  MINLEN:36