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
  print(lat)
  print(lng)
  print(typeof(lat))
  if(is.na(lat) || is.na(lng)) {
    return("Location not found")
  }
  maxdistance <- queryData$maxdistance
  numofbathrooms <- queryData$numofbathrooms
  numofbedrooms <- queryData$numofbedrooms
  numofbeds <- queryData$numofbeds
  #pricemax <- queryData$maxprice[1]
  #pricemin <- queryData$minprice[2]
  #resultsperpage <- queryData$resultsperpage
  #page <- queryData$page
  required_parameters1 <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=1" 
  )
  
  required_parameters2 <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=2" 
  )
  
  required_parameters3 <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=3" 
  )
  
  required_parameters4 <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=4" 
  )
  
  required_parameters5 <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=5" 
  )
  
  required_parameters6 <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=6" 
  )
  
  query1 <- paste0(base_url, key_parameter, key, required_parameters1)
  query2 <- paste0(base_url, key_parameter, key, required_parameters2)
  query3 <- paste0(base_url, key_parameter, key, required_parameters3)
  query4 <- paste0(base_url, key_parameter, key, required_parameters4)
  query5 <- paste0(base_url, key_parameter, key, required_parameters5)
  query6 <- paste0(base_url, key_parameter, key, required_parameters6)
  
  data1 <- fromJSON(query1)
  data2 <- fromJSON(query2)
  data3 <- fromJSON(query3)
  data4 <- fromJSON(query4)
  data5 <- fromJSON(query5)
  data6 <- fromJSON(query6)

  data1 <- data1$result
  data2 <- data2$result
  data3 <- data3$result
  data4 <- data4$result
  data5 <- data5$result
  data6 <- data6$result
  
  if(!is.null(nrow(data1))) {
    data1 <- flatten(data1)
  }
  
  combinedData <- data1
  
  if(!is.null(nrow(data2))) {
    data2 <- flatten(data2)
    combinedData <- rbind(combinedData, data2)
  }
  
  if(!is.null(nrow(data3))) {
    data3 <- flatten(data3)
    combinedData <- rbind(combinedData, data3)
  }
  
  if(!is.null(nrow(data4))) {
    data4 <- flatten(data4)
    combinedData <- rbind(combinedData, data4)
  }
  
  if(!is.null(nrow(data5))) {
    data5 <- flatten(data5)
    combinedData <- rbind(combinedData, data5)
  }
  
  if(!is.null(nrow(data6))) {
    data6 <- flatten(data6)
    combinedData <- rbind(combinedData, data6)
  }
  
  #View(combinedData)
  
  if(is.null(nrow(data4))){
    return(combinedData)
  } else if(isinstantbook){
    combinedData <- filter(combinedData,
                   attr.occupancy >= guests,
                   attr.instantBookable == isinstantbook,
                   attr.bathrooms >= numofbathrooms,
                   attr.bedrooms >= numofbedrooms,
                   attr.beds >= numofbeds)
    return(combinedData)
  } else{
    combinedData <- filter(combinedData,
                   attr.occupancy >= guests,
                   attr.bathrooms >= numofbathrooms,
                   attr.bedrooms >= numofbedrooms,
                   attr.beds >= numofbeds)
    return(combinedData)
  }
}





