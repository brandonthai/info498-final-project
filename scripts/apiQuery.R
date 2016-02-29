library(jsonlite)
source('scripts/getLatLng.R')

get_data <- function(user_city, user_state) {
  base_url <- "https://zilyo.p.mashape.com/search?"
  key_parameter <- "mashape-key="
  key <- "nowlV7qpGSmshTJ2jv6AeLUAGUrjp1632Pzjsn40XflJySxVK5"
  latlng <- getLatLng(user_city, user_state)
  lat <- latlng$lat
  lng <- latlng$lon
  
  required_parameters <- paste0("&latitude=", lat, "&longitude=", lng)
  
  query <- paste0(base_url, key_parameter, key, required_parameters)
  data <- fromJSON(query)
  return(data$result)
}
