library(plotly)
library(dplyr)
library(leaflet)
source('scripts/apiQuery.r')

build_map <- function(queryData) {
  data <- get_data(queryData)
  View(data)
  lat <- unlist(lapply(data$latLng, unlist))[seq(1, nrow(data)*2, 2)]
  lng <- unlist(lapply(data$latLng, unlist))[seq(2, nrow(data)*2, 2)]
  data$latitude = lat
  data$longitude = lng
  
#   content <- paste(sep = "<br/>",
#                               "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
#                               "606 5th Ave. S",
#                               "Seattle, WA 98138"
#   )
  
  map <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(data, lat = data$latitude, lng = data$longitude) %>%
#     addPopups(data, lat = data$latitude, lng = data$lng, content,
#               options = popupOptions(closeButton = FALSE)
#     )
  return(map)
}

  
  


