## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  eval     = FALSE
)

## -----------------------------------------------------------------------------
#  renv::settings$ignored.packages("dplyr")

## -----------------------------------------------------------------------------
#  renv::settings$ignored.packages()

## ----config, eval=TRUE, echo=FALSE--------------------------------------------
config <- yaml::read_yaml("../inst/config.yml")
data <- do.call(rbind, config)
knitr::kable(data, format = "simple")

