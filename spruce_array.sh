#!/bin/bash
 
#SBATCH --job-name=spruce
#SBATCH --time=40:00:00
#SBATCH --mem-per-cpu=100
#SBATCH --output=output.txt
#SBATCH --array=1-750
#SBATCH --mail-user=christina.schaedel@nau.edu
#SBATCH --mail-type=ALL
#SBATCH --exclusive	

module load R
Rscript spruce_modeling.R ${SLURM_ARRAY_TASK_ID}
