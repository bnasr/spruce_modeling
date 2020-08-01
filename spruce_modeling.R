#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)!=2) {
  stop("Two arguments must be supplied input and output files", call.=FALSE)
} 

project_dir <- '/scratch/ss3526/spruce_modeling/'
# project_dir <- '~/Projects/spruce_modeling/'

input_dir <- paste0(project_dir, 'input/')
output_dir <- paste0(project_dir, 'output/')

#create output dir, if does not exists
dir.create(output_dir, showWarnings = FALSE)

input_file <- paste0(input_dir, args[1], '.rds')
output_file <- paste0(output_dir, args[2], '.RData')

params_file <- paste0(project_dir, 'parameter_ranges.csv')



#devtools::install_github("khufkens/phenor")
try(library(phenor))

models = c("LIN","TT","TTs","PTT","PTTs",
           "M1","M1s","AT", "SQ", "SQb", 
           "SM1", "SM1b", "PA", "PAb", "PM1",
           "PM1b", "UM1", "SGSI", "AGSI")

# calibrate single model using simulated annealing
input_data <- try(readRDS(input_file))


#running all models
model_fits <- try(mapply(function(model){
  pr_fit(model = models,
         data = input_data,
         method = "GenSA",
         control = list(max.call = 1000000),
         par_ranges = file.path(params_file))
},model = models))


# model comparison
model_comparison <- try(pr_fit_comparison(
  data = input_data,
  method = "GenSA",
  control = list(max.call = 2000,
                 temperature = 10000),
  par_ranges = file.path(params_file),
  ncores = 1
))

save(list = c('input_file', 'input_data', 'model_fits', 'model_comparison'), file = output_file)


