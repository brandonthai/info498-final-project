library(dplyr)
library(leaflet)
source('scripts/api_query.r')

build_map <- function(queryData) {
  #Get data frame from API
  data <- get_data(queryData)
  
  # Unlist photo and grabs one large photo for popup
  data <- data %>%
            rowwise() %>%
            mutate(displayPhoto = unlist(photos)[1])
  #View(data)
  
  
  #Only get the LAT/LNG of location if data is not null
  if(nrow(data) != 0 && !is.null(nrow(data))) {
    print(nrow(data))
    lat <- unlist(lapply(data$latLng, unlist))[seq(1, nrow(data)*2, 2)]
    lng <- unlist(lapply(data$latLng, unlist))[seq(2, nrow(data)*2, 2)]
    data$latitude = lat
    data$longitude = lng
  }
  
  #Create the popup window with following information
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
          '<img heigth=150, width=150, src="', photo, '">'
    )
  }
  
  #Get LAT/LNG of user's inputed city, state
  latlng <- getLatLng(queryData$city, queryData$state)
  cityLat <- latlng$lat
  cityLng <- latlng$lon
  
  #If data frame is null then display blank map of location
  #Else dislay map with markers of rentals
  if(nrow(data) == 0 || is.null(nrow(data))) {
    map <- leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng = cityLng, lat = cityLat, zoom = 12)
  } else {
    map <- leaflet(data) %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(clusterOptions = markerClusterOptions(),
                 lng = data$longitude,
                 lat = data$latitude,
                 popup = content(data$attr.heading,
                                 data$attr.beds,
                                 data$attr.bedrooms,
                                 data$attr.bathrooms,
                                 data$price.nightly,
                                 data$price.weekly,
                                 data$price.monthly,
                                 data$provider.url,
                                 data$displayPhoto
                 )
      )
  }
  return(map)
}

  
  


