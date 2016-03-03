library(plotly)
library(dplyr)
source('scripts/apiQuery.R')

build_map <- function(queryData) {
  data <- get_data(queryData)
  lat <- unlist(lapply(data$latLng, unlist))[seq(1, 50, 2)]
  lng <- unlist(lapply(data$latLng, unlist))[seq(2, 50, 2)]
  data$lat = lat
  data$lng = lng
  p <- plot_ly(data, lat = lat, lon = lng, type = 'scattergeo', locationmode = 'USA-states', mode = 'markers') %>%
    layout(title = 'Most trafficked US airports<br>(Hover for airport)')
  return(p)
}

  
  
