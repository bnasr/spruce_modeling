#!/bin/bash
 
#SBATCH --job-name=spruce
#SBATCH --time=00:00:05
#SBATCH --mem-per-cpu=100
#SBATCH --nodes=1
#SBATCH --output=output/output_%a.txt
#SBATCH --array=1-30
#SBATCH --mail-user=bijan.s.nasr@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --exclusive	

module load R
Rscript spruce_modeling.R input_${SLURM_ARRAY_TASK_ID} output_${SLURM_ARRAY_TASK_ID}
