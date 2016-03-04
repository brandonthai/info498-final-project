library(jsonlite)
source('scripts/getLatLng.r')

get_data <- function(queryData) {
  base_url <- "https://zilyo.p.mashape.com/search?"
  key_parameter <- "mashape-key="
  key <- "nowlV7qpGSmshTJ2jv6AeLUAGUrjp1632Pzjsn40XflJySxVK5"
  guests <- queryData$guests
  provider <- queryData$provider
  isinstantbook <- queryData$isinstantbook
  latlng <- getLatLng(queryData$city, queryData$state)
  lat <- latlng$lat
  lng <- latlng$lon
  maxdistance <- queryData$maxdistance
  numofbathrooms <- queryData$numofbathrooms
  numofbedrooms <- queryData$numofbedrooms
  numofbeds <- queryData$numofbeds
  pricemax <- queryData$maxprice[1]
  pricemin <- queryData$minprice[2]
  resultsperpage <- queryData$resultsperpage
  
  
  required_parameters <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50
  )
  
  query <- paste0(base_url, key_parameter, key, required_parameters)
  print(query)
  data <- fromJSON(query)
  data <- data$result
  data <- flatten(data)
  data <- filter(data,
                 attr.occupancy >= guests,
                 attr.instantBookable == isinstantbook,
                 attr.bathrooms >= numofbathrooms,
                 attr.bedrooms >= numofbedrooms,
                 attr.beds >= numofbeds)
  return(data)
}






