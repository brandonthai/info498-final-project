# Install localgeo package
# devtools::install_github("hrbrmstr/localgeo")

library(localgeo)

# Gets the lat/ln of a specified city + state 
getLatLng <- function(city_search, state_search) {
  p <- geocode(city_search, state_search)
  return(p)
}



