#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)!=1) {
  stop("The input argument must supply Task ID", call.=FALSE)
} 

project_dir <- getwd()

if(Sys.info()['nodename']=='wind.nauhpc') 
  project_dir <- paste0('/scratch/', Sys.info()['login'], '/spruce_modeling/')


total_iterations <- 25

task_ID <- args[1]
model_no <- ceiling(task_ID / total_iterations)
iteration_no <- task_ID %% total_iterations
iteration_no[iteration_no == 0] <- total_iterations


cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'started', '\n')


input_dir <- paste0(project_dir, '/input/')
output_dir <- paste0(project_dir, '/output/')

#create output dir, if does not exists
dir.create(output_dir, showWarnings = FALSE)

params_file <- paste0(project_dir, '/parameter_ranges.csv')

input_file <- paste0(input_dir, 'input_', model_no, '.rds')
output_file <- paste0(output_dir, 'output_', model_no, '_', iteration_no, '.RData')


cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'input_file = ', input_file, '\n')
cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'output_file = ', output_file, '\n')
cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'params_file = ', params_file, '\n')


#devtools::install_github("khufkens/phenor")
try(library(phenor))

models = c("LIN","TT","TTs","PTT","PTTs",
           "M1","M1s","AT", "SQ", "SQb", 
           "SM1", "SM1b", "PA", "PAb", "PM1",
           "PM1b", "UM1", "SGSI", "AGSI")

# calibrate single model using simulated annealing
input_data <- try(readRDS(input_file))


cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'model_fits started', '\n')
#running all models
model_fits <- try(mapply(function(model){
  pr_fit(model = model,
         data = input_data,
         method = "GenSA",
         control = list(max.call = 40000),
         par_ranges = file.path(params_file))
},
model = models))

cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'model_fits finished', '\n')

# cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'model_comparison started', '\n')
# 
# model_comparison <- try(pr_fit_comparison(
#   data = input_data,
#   method = "GenSA",
#   control = list(max.call = 40000,
#                  temperature = 10000),
#   par_ranges = file.path(params_file),
#   ncores = 1
# ))
# 
# cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'model_comparison finished', '\n')


cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'saving the data ...', '\n')
# save(list = c('input_file', 'input_data', 'model_fits', 'model_comparison'), file = output_file)
save(list = c('input_file', 'input_data', 'model_fits'), file = output_file)

cat(as.character(Sys.time()), task_ID, model_no, iteration_no, 'done!', '\n')

