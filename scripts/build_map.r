library(plotly)
library(dplyr)
source('scripts/apiQuery.R')

build_map <- function(queryData) {
  data <- get_data(queryData)
  lat <- unlist(lapply(data$latLng, unlist))[seq(1, nrow(data)*2, 2)]
  lng <- unlist(lapply(data$latLng, unlist))[seq(2, nrow(data)*2, 2)]
  data$latitude = lat
  data$longitude = lng
#  points <- function() {
#     cbind(data$latitude, data$longitude)
#   }
    
  m <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(data, lat = data$latitude, lng = data$longitude)
  return(m)
}

  
  


