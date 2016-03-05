library(plotly)
library(dplyr)
library(leaflet)
source('scripts/apiQuery.r')

build_map <- function(queryData) {
  data <- get_data(queryData)
  #View(data)
  if(nrow(data) != 0) {
    lat <- unlist(lapply(data$latLng, unlist))[seq(1, nrow(data)*2, 2)]
    lng <- unlist(lapply(data$latLng, unlist))[seq(2, nrow(data)*2, 2)]
    data$latitude = lat
    data$longitude = lng
  }
  
  content <- paste(sep = "<br/>",
                              "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
                              "606 5th Ave. S",
                              "Seattle, WA 98138"
  )
  
  
  latlng <- getLatLng(queryData$city, queryData$state)
  cityLat <- latlng$lat
  cityLng <- latlng$lon
  
  if(nrow(data) != 0) {
    map <- leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(data, lat = data$latitude, lng = data$longitude) %>%
      addPopups(data, lat = data$latitude, lng = data$longitude, content)
  } else {
    map <- leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng = cityLng, lat = cityLat, zoom = 12)
  }
  return(map)
}

  
  



