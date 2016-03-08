library(dplyr)
library(leaflet)
source('scripts/api_query.r')

build_map <- function(queryData) {
  data <- get_data(queryData)
  #View(data)
  if(!is.null(nrow(data))) {
    lat <- unlist(lapply(data$latLng, unlist))[seq(1, nrow(data)*2, 2)]
    lng <- unlist(lapply(data$latLng, unlist))[seq(2, nrow(data)*2, 2)]
    data$latitude = lat
    data$longitude = lng
  }
  
  content <- function(heading, beds, bedrooms, bathrooms, nightly, weekly, monthly, link, photo){
    paste(sep = '',
          '<h4>', heading, '</h4>',
          '<h5>Number of beds: ', beds, '</h5>',
          '<h5>Number of bedrooms: ', bedrooms, '</h5>',
          '<h5>Number of bathrooms: ', bathrooms, '</h5>',
          '<h5>Price per night: $', nightly, '</h5>',
          '<h5>Price per week: $', weekly, '</h5>',
          '<h5>Price per month: $', monthly, '</h5>',
          "<a href='", link, "'>Link to provider's listing.</a> </br> </br>",
          '<img heigth=150, width=150, src="', unlist(photo), '">'
    )
  }
  
  latlng <- getLatLng(queryData$city, queryData$state)
  cityLat <- latlng$lat
  cityLng <- latlng$lon
  
  if(!is.null(nrow(data))) {
    map <- leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(data,
                 lat = data$latitude,
                 lng = data$longitude,
                 #clusterOptions = markerClusterOptions(),
                 popup = content(data$attr.heading,
                                 data$attr.beds,
                                 data$attr.bedrooms,
                                 data$attr.bathrooms,
                                 data$price.nightly,
                                 data$price.weekly,
                                 data$price.monthly,
                                 data$provider.url,
                                 data$photos
                          )
                 )
  } else {
    map <- leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng = cityLng, lat = cityLat, zoom = 12)
  }
  return(map)
}

  
  




