rm(list=ls())

# NAU-ID cs2737

devtools::install_github("khufkens/phenor")
library(phenor)

setwd("D:/FL/SPRUCE/Spruce_pheno_modeling/")


# calibrate single model using simulated annealing
input_1 <- readRDS("Spruce_modeling_spring/Spruce_input_rds/input_1.rds")

# linear model
input_1_lin <- pr_fit(
  model = "LIN",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Thermal Time model
input_1_tt <- pr_fit(
  model = "TT",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Thermal Time model (sigmoidal temperature response)
input_1_tts <- pr_fit(
  model = "TTs",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Photo Thermal Time model
input_1_ptt <- pr_fit(
  model = "PTT",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Photo Thermal Time model (sigmoidal temperature response)
input_1_ptts <- pr_fit(
  model = "PTTs",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# M1
input_1_m1 <- pr_fit(
  model = "M1",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# M1 (sequential temperature response)
input_1_m1s <- pr_fit(
  model = "M1s",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Alternative Model
input_1_at <- pr_fit(
  model = "AT",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Sequential Model
input_1_sq <- pr_fit(
  model = "SQ",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))

# Sequential Model (using bell-shaped chilling response)
input_1_sqb <- pr_fit(
  model = "SQb",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Sequential Model (variant 1)
input_1_sm1 <- pr_fit(
  model = "SM1",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Sequential Model (variant 1, using bell-shaped chilling response)
input_1_sm1b <- pr_fit(
  model = "SM1b",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Parallel model
input_1_pa <- pr_fit(
  model = "PA",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Parallel model
input_1_pab <- pr_fit(
  model = "PAb",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Parallel M1 model
input_1_pm1 <- pr_fit(
  model = "PM1",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Parallel M1 model (using a bell-shaped chilling response)
input_1_pm1b <- pr_fit(
  model = "PM1b",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Unified M1 model
input_1_um1 <- pr_fit(
  model = "UM1",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Standard growing season index model
input_1_sgsi <- pr_fit(
  model = "SGSI",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# Accumulated growing season index model
input_1_agsi <- pr_fit(
  model = "AGSI",
  data = input_1,
  method = "GenSA",
  control = list(max.call = 1000000),
  par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"))


# model comparison
model_comparison <- pr_fit_comparison(
    models = c("LIN","TT","TTs","PTT","PTTs","M1","M1s","AT",
               "SQ", "SQb", "SM1", "SM1b", "PA", "PAb", "PM1","PM1b", "UM1", "SGSI", "AGSI"),
    data = input_1,
    method = "GenSA",
    control = list(max.call = 2000,
             temperature = 10000),
    par_ranges = file.path("D:/FL/SPRUCE/Spruce_pheno_modeling/parameter_ranges.csv"),
    ncores = 1
  )





























