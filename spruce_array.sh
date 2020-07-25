#!/bin/bash
 
#SBATCH --job-name=spruce_array
#SBATCH --time=00:01:00
#SBATCH --mem=1
#SBATCH --input=/scratch/ss3526/spruce_modeling/input/input_%a.rds
#SBATCH --output=/scratch/ss3526/spruce_modeling/output/output_%a.txt
#SBATCH --array=1-30
#SBATCH --mail-user=ss3526@nau.edu
#SBATCH --mail-type=ALL
#SBATCH --exclusive	

load module R
Rscript spruce_spring_models_airtemp_soiltemp.R input_${SLURM_ARRAY_TASK_ID} output_${SLURM_ARRAY_TASK_ID}
