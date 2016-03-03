library(plotly)
library(dplyr)
source('scripts/apiQuery.R')


build_map <- function(queryData) {
  data <- get_data(queryData)
  return(data)
}