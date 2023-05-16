## ------------------------------------------
## Description: Maps individual libraries
##              to the evigene transcriptome
##              using RSEM and Bowtie2
## ------------------------------------------


## ------------------------------------------
## Environment
## ------------------------------------------

WORK_DIR=/work/rpapa/lrodriguez/projects/Zerene2018/rsem
READ_DIR=/work/rpapa/lrodriguez/projects/Zerene2018/corrected_reads
SOFT_DIR=/work/rpapa/lrodriguez/software/RSEM-1.3.0
TRAN_DIR=/work/rpapa/lrodriguez/projects/Zerene2018/transcriptomes

module load bowtie2/2.2.6

## ------------------------------------------
## Select file using array number
## -----------------------------------------

cd $READ_DIR

ID=$((SLURM_ARRAY_TASK_ID -1))
FILES=($(ls B1*_R1*gz))
FILE=${FILES[ID]}
SAMPLE=$(echo $FILE | cut -f1 -d'_')

## --------------------------------------
## Concatenate technical replicates
## --------------------------------------

mdir $WORK_DIR/$SAMPLE

cat *$SAMPLE*_R1*gz > $WORK_DIR/$SAMPLE/R1.fq.gz
cat *$SAMPLE*_R2*gz > $WORK_DIR/$SAMPLE/R2.fq.gz

## -----------------------------------------
## Map library
## ----------------------------------------

cd $WORK_DIR/$SAMPLE

$SOFT_DIR/rsem-calculate-expression --num-threads 8 \
                                    --bowtie2 \
                                    --paired-end \
                                    --bowtie2-k 8 \
                                    --bowtie2-missmatch-rate 0.07 \
                                    R1.fq.gz \
                                    R2.fq.gz \
                                    evigene_tr.fa \
                                    $SAMPLE
                                    1> ./rsem.log \
                                    2> ./rsem.error

## -----------------------
## Clean
## -----------------------

rm $WORK_DIR/$SAMPLE/R1.fq.gz
rm $WORK_DIR/$SAMPLE/R2.fq.gz


