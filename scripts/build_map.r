library(plotly)
library(dplyr)
source('scripts/apiQuery.R')

build_map <- function(queryData) {
  data <- get_data(queryData)
  lat <- unlist(lapply(data$latLng, unlist))[seq(1, nrow(data)*2, 2)]
  lng <- unlist(lapply(data$latLng, unlist))[seq(2, nrow(data)*2, 2)]
  data$latitude = lat
  data$longitude = lng
  p <- plot_ly(data, lat = latitude, lon = longitude, type = 'scattergeo', locationmode = 'USA-states', mode = 'markers') %>%
    layout(title = 'Most trafficked US airports<br>(Hover for airport)')
  return(p)
}

  
  


