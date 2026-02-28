## -----------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(nhanesdata)
library(dplyr)
library(srvyr)

## -----------------------------------------------------------------------------
# # Load demographics data
# demo <- read_nhanes("demo")
# 
# # Create design with interview weights
# design_int <- create_design(
#   dsn = demo,
#   start_yr = 1999,
#   end_yr = 2011,
#   wt_type = "interview"
# )
# 
# # Calculate weighted means
# design_int |>
#   summarize(
#     mean_age = survey_mean(ridageyr, na.rm = TRUE),
#     pct_female = survey_mean(riagendr == 2, na.rm = TRUE)
#   )

## -----------------------------------------------------------------------------
# # Load demographics and body measures
# demo <- read_nhanes("demo")
# bmx <- read_nhanes("bmx")
# 
# combined <- demo |>
#   left_join(bmx, by = c("seqn", "year"))
# 
# # Use MEC weights because body measures require exam participation
# design_mec <- create_design(
#   dsn = combined,
#   start_yr = 2007,
#   end_yr = 2017,
#   wt_type = "mec"
# )
# 
# # Weighted BMI analysis
# design_mec |>
#   filter(!is.na(bmxbmi)) |>
#   summarize(
#     mean_bmi = survey_mean(bmxbmi, na.rm = TRUE),
#     pct_obese = survey_mean(bmxbmi >= 30, na.rm = TRUE)
#   )

## -----------------------------------------------------------------------------
# # Load demographics and fasting lab data
# demo <- read_nhanes("demo")
# glu <- read_nhanes("glu")
# 
# combined <- demo |>
#   left_join(glu, by = c("seqn", "year"))
# 
# # Use fasting weights for glucose analysis
# design_fast <- create_design(
#   dsn = combined,
#   start_yr = 2005,
#   end_yr = 2015,
#   wt_type = "fasting"
# )
# 
# # Analyze fasting glucose
# design_fast |>
#   filter(!is.na(lbxglu)) |>
#   summarize(
#     mean_glucose = survey_mean(lbxglu, na.rm = TRUE)
#   )

## -----------------------------------------------------------------------------
# # Data might be missing 2007-2010 cycles
# # Weights calculated on cycles present, not timespan
# design <- create_design(
#   dsn = demo,
#   start_yr = 1999,
#   end_yr = 2017,
#   wt_type = "interview"
# )

