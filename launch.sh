#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --nodes=10
#SBATCH --array=1-10
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=4G
#SBATCH --account=def-ksmccann
#SBATCH --mail-user=kcazelle@uoguelph.ca
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR

# Run my job 12 years per nodes parallellize x 3 (5 years at a time) x 4 configs
parallel --delay 1 Rscript ./scr_extract.R $SLURM_ARRAY_TASK_ID {1} {2} {3} {4} {5} ::: {1..2} ::: {1..2} ::: {1..6} ::: 12 ::: 2

