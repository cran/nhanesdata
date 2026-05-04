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

catalog <- rbind(catalog, data.frame(
  Dataset = "MORTALITY",
  Description = "NHANES-Linked Mortality (NDI) - Follow-up Through 2019",
  Category = "Linkage",
  stringsAsFactors = FALSE
))

## -----------------------------------------------------------------------------
catalog |>
  arrange(Dataset) |>
  reactable::reactable(
    searchable = TRUE,
    columns = list(
      Dataset = reactable::colDef(width = 120),
      Category = reactable::colDef(width = 140),
      Description = reactable::colDef(minWidth = 300)
    )
  )

