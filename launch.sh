#!/bin/bash
#SBATCH --time=6:00:00
#SBATCH --nodes=5
#SBATCH --array=1-5
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=4G
#SBATCH --account=def-ksmccann
#SBATCH --mail-user=kcazelle@uoguelph.ca
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR

# Run my job 24 years per nodes parallellize x 4 config
# Cannot massively parallellize cause the ftp server won't suport this
parallel --delay 1 Rscript ./scr_extract.R $SLURM_ARRAY_TASK_ID {1} {2} {3} ::: {1..2} ::: {1..2} ::: 24

