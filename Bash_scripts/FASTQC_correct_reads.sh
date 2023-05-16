## --------------------
## Description
## --------------------

#  Uses AfterQC.py to correct 


## ------------------
## Varibales
## ------------------

WORK_DIR=/home/lfern/projects/Zerene2018/corrected_data
SOFT_DIR=/home/lfern/software/AfterQC-master
DATA_DIR=/home/lfern/projects/Zerene2018/raw_data

## ------------------
## Run AfterQC
## ------------------
cd $DATA_DIR

python $SOFT_DIR/after.py --read1_flag '_R1_'\
                          --read2_flag '_R2_'\
                          -g $WORK_DIR/good\
                          -b $WORK_DIR/bad\
                          -r $WORK_DIR/report\
                          -f -1\
                          -t -1\
                          -q 26\
                          -u 10\
                          -p 40\
                          -n 6\
