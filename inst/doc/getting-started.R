## -----------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# # install.packages("pak")
# pak::pak("kyleGrealis/nhanesdata")

## -----------------------------------------------------------------------------
library(nhanesdata)
library(dplyr)
library(ggplot2)

## -----------------------------------------------------------------------------
demo <- read_nhanes("demo")

## -----------------------------------------------------------------------------
# demo <- read_nhanes("demo")
# glimpse(demo)

## -----------------------------------------------------------------------------
demo |>
  filter(!is.na(ridageyr)) |>
  ggplot(aes(x = ridageyr)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "white") +
  facet_wrap(~year, ncol = 4) +
  labs(
    title = "NHANES Age Distribution by Survey Cycle",
    x = "Age (years)",
    y = "Count"
  ) +
  theme_minimal()

## -----------------------------------------------------------------------------
# get_url("DEMO")   # 1999-2000 codebook
# get_url("DEMO_I") # 2015-2016 codebook

## -----------------------------------------------------------------------------
# demo <- read_nhanes("demo")
# bpx <- read_nhanes("bpx")
# bmx <- read_nhanes("bmx")
# 
# analysis_data <- demo |>
#   inner_join(bpx, by = c("seqn", "year")) |>
#   inner_join(bmx, by = c("seqn", "year")) |>
#   select(year, seqn, ridageyr, riagendr, bpxsy1, bmxbmi)

## -----------------------------------------------------------------------------
# demo <- read_nhanes("demo")
# 
# # Recent cycles only
# recent <- demo |>
#   filter(year >= 2015)
# 
# # Compare time periods
# demo |>
#   mutate(
#     period = case_when(
#       year < 2010 ~ "1999-2009",
#       year < 2020 ~ "2010-2019",
#       TRUE ~ "2020+"
#     )
#   ) |>
#   group_by(period) |>
#   summarise(n = n())

## -----------------------------------------------------------------------------
# term_search("blood pressure")

## -----------------------------------------------------------------------------
# var_search("BPXSY1")

## -----------------------------------------------------------------------------
bmx <- read_nhanes("bmx")

## -----------------------------------------------------------------------------
"bmxht" %in% names(bmx)

## -----------------------------------------------------------------------------
bpx <- read_nhanes("bpx")
bp_combined <- demo |>
  filter(ridageyr >= 18) |>
  select(seqn, year, ridageyr, riagendr, ridreth1) |>
  inner_join(
    bpx |> select(seqn, year, bpxsy1, bpxdi1),
    by = c("seqn", "year")
  )
bp_summary <- bp_combined |>
  filter(!is.na(bpxsy1), !is.na(bpxdi1), bpxsy1 > 0, bpxdi1 > 0) |>
  mutate(
    age_group = cut(
      ridageyr,
      breaks = c(18, 30, 40, 50, 60, 70, 80, Inf),
      labels = c(
        "18-29", "30-39", "40-49", "50-59",
        "60-69", "70-79", "80+"
      ),
      right = FALSE
    )
  ) |>
  group_by(age_group) |>
  summarize(
    n = n(),
    mean_systolic = mean(bpxsy1),
    mean_diastolic = mean(bpxdi1),
    .groups = "drop"
  )

## -----------------------------------------------------------------------------
# demo <- read_nhanes("demo")
# bpx <- read_nhanes("bpx")
# 
# bp_analysis <- demo |>
#   filter(ridageyr >= 18) |>
#   select(seqn, year, ridageyr, riagendr, ridreth1) |>
#   inner_join(
#     bpx |> select(seqn, year, bpxsy1, bpxdi1),
#     by = c("seqn", "year")
#   ) |>
#   filter(!is.na(bpxsy1), !is.na(bpxdi1), bpxsy1 > 0, bpxdi1 > 0) |>
#   mutate(
#     age_group = cut(
#       ridageyr,
#       breaks = c(18, 30, 40, 50, 60, 70, 80, Inf),
#       labels = c(
#         "18-29", "30-39", "40-49", "50-59",
#         "60-69", "70-79", "80+"
#       ),
#       right = FALSE
#     )
#   )
# 
# bp_summary <- bp_analysis |>
#   group_by(age_group) |>
#   summarize(
#     n = n(),
#     mean_systolic = mean(bpxsy1),
#     mean_diastolic = mean(bpxdi1),
#     .groups = "drop"
#   )

## -----------------------------------------------------------------------------
bp_summary |>
  ggplot(aes(x = age_group)) +
  geom_col(aes(y = mean_systolic), fill = "coral", alpha = 0.7) +
  geom_col(aes(y = mean_diastolic), fill = "steelblue", alpha = 0.7) +
  labs(
    title = "Blood Pressure Increases with Age",
    subtitle = "Mean systolic (coral) and diastolic (blue) BP by age group",
    x = "Age Group",
    y = "Blood Pressure (mmHg)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

