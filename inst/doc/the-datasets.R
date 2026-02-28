## -----------------------------------------------------------------------------
library(dplyr)
library(reactable)

knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>"
)

config <- yaml::read_yaml(
  system.file("extdata", "datasets.yml", package = "nhanesdata")
)

catalog <- do.call(rbind, lapply(config$datasets, function(x) {
  data.frame(
    Dataset = toupper(x$name),
    Description = x$description,
    Category = tools::toTitleCase(x$category),
    stringsAsFactors = FALSE
  )
}))

## -----------------------------------------------------------------------------
catalog |>
  arrange(Dataset) |>
  reactable::reactable(
    searchable = TRUE
  )

