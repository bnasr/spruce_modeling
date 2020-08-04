#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

cat(as.character(Sys.time()), 'started', '\n')

# test if there is at least one argument: if not, return an error
if (length(args)!=2) {
  stop("Two arguments must be supplied input and output files", call.=FALSE)
} 

project_dir <- '/scratch/ss3526/spruce_modeling/'

#if running on Bijan's laptop
if(.Platform$pkgType=='mac.binary') {
  project_dir <- '~/Projects/spruce_modeling/'
  args <- c('input_1', 'output_1')
}

input_dir <- paste0(project_dir, 'input/')
output_dir <- paste0(project_dir, 'output/')

#create output dir, if does not exists
dir.create(output_dir, showWarnings = FALSE)

input_file <- paste0(input_dir, args[1], '.rds')
output_file <- paste0(output_dir, args[2], '.RData')

params_file <- paste0(project_dir, 'parameter_ranges.csv')

cat(as.character(Sys.time()), 'input_file = ', input_file, '\n')
cat(as.character(Sys.time()), 'output_dir = ', output_dir, '\n')
cat(as.character(Sys.time()), 'project_dir = ', project_dir, '\n')


#devtools::install_github("khufkens/phenor")
try(library(phenor))

models = c("LIN","TT","TTs","PTT","PTTs",
           "M1","M1s","AT", "SQ", "SQb", 
           "SM1", "SM1b", "PA", "PAb", "PM1",
           "PM1b", "UM1", "SGSI", "AGSI")

# calibrate single model using simulated annealing
input_data <- try(readRDS(input_file))


cat(as.character(Sys.time()), 'model_fits started', '\n')
#running all models
model_fits <- try(mapply(function(model){
  pr_fit(model = model,
         data = input_data,
         method = "GenSA",
         control = list(max.call = 1000000),
         par_ranges = file.path(params_file))
},model = models))
cat(as.character(Sys.time()), 'model_fits finished', '\n')


cat(as.character(Sys.time()), 'model_comparison started', '\n')
# model comparison
model_comparison <- try(pr_fit_comparison(
  data = input_data,
  method = "GenSA",
  control = list(max.call = 2000,
                 temperature = 10000),
  par_ranges = file.path(params_file),
  ncores = 1
))
cat(as.character(Sys.time()), 'model_comparison finished', '\n')

cat(as.character(Sys.time()), 'saving the data ...', '\n')
save(list = c('input_file', 'input_data', 'model_fits', 'model_comparison'), file = output_file)

cat(as.character(Sys.time()), 'done!', '\n')

