library(jsonlite)
source('scripts/get_lat_lng.r')

# This function will call to the API and query for the information 
# requested to the user
get_data <- function(queryData) {
  base_url <- "https://zilyo.p.mashape.com/search?"
  key_parameter <- "mashape-key="
  key <- "nowlV7qpGSmshTJ2jv6AeLUAGUrjp1632Pzjsn40XflJySxVK5"
  
  guests <- queryData$guests
  provider <- queryData$provider
  isinstantbook <- queryData$isinstantbook
  
  #Get LAT/LNG of user's inputed city, state
  latlng <- getLatLng(queryData$city, queryData$state)
  lat <- latlng$lat
  lng <- latlng$lon
  
  #If location is not valid
  if(is.na(lat) || is.na(lng)) {
    return("Location not found.")
  }
  
  #Grap required varibles from the user's filter
  maxdistance <- queryData$maxdistance
  numofbathrooms <- queryData$numofbathrooms
  numofbedrooms <- queryData$numofbedrooms
  numofbeds <- queryData$numofbeds
  
  #Paste url of user's requested parameters
  required_parameters1 <- pasteURL(lat, lng, maxdistance, provider, 1)
  required_parameters2 <- pasteURL(lat, lng, maxdistance, provider, 2)
  required_parameters3 <- pasteURL(lat, lng, maxdistance, provider, 3)
  required_parameters4 <- pasteURL(lat, lng, maxdistance, provider, 4)
#   required_parameters5 <- pasteURL(lat, lng, maxdistance, provider, 5)
#   required_parameters6 <- pasteURL(lat, lng, maxdistance, provider, 6)
  
  #Paste required parameters with API url and API key
  query1 <- paste0(base_url, key_parameter, key, required_parameters1)
  query2 <- paste0(base_url, key_parameter, key, required_parameters2)
  query3 <- paste0(base_url, key_parameter, key, required_parameters3)
  query4 <- paste0(base_url, key_parameter, key, required_parameters4)
#   query5 <- paste0(base_url, key_parameter, key, required_parameters5)
#   query6 <- paste0(base_url, key_parameter, key, required_parameters6)
  
  
  #Query API for data frame
  data1 <- fromJSON(query1)
  data2 <- fromJSON(query2)
  data3 <- fromJSON(query3)
  data4 <- fromJSON(query4)
#   data5 <- fromJSON(query5)
#   data6 <- fromJSON(query6)

  #Get the results from the API
  data1 <- data1$result
  data2 <- data2$result
  data3 <- data3$result
  data4 <- data4$result
#   data5 <- data5$result
#   data6 <- data6$result
  
  #Only flatten if the data frame is not null
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
  
#   if(!is.null(nrow(data4))) {
#     data4 <- flatten(data4)
#     combinedData <- rbind(combinedData, data4)
#   }
#   
#   if(!is.null(nrow(data5))) {
#     data5 <- flatten(data5)
#     combinedData <- rbind(combinedData, data5)
#   }
#   
#   if(!is.null(nrow(data6))) {
#     data6 <- flatten(data6)
#     combinedData <- rbind(combinedData, data6)
#   }
#   
  #View(combinedData)
  
  #If final combined data frame is null, return that data empty data frame
  if(is.null(nrow(combinedData))){
    return(combinedData)
  } else if(isinstantbook){ #If instant book is checked, filter results with instantbook and user's inputed filters
    combinedData <- combinedData %>%
                      filter(attr.occupancy >= guests,
                             attr.instantBookable == isinstantbook,
                             attr.bathrooms >= numofbathrooms,
                             attr.bedrooms >= numofbedrooms,
                             attr.beds >= numofbeds
                      )
    return(combinedData)
  } else{ #Else, user did not select instant book, only filter results with user's inputed filters
    combinedData <- combinedData %>%
                      filter(attr.occupancy >= guests,
                             attr.bathrooms >= numofbathrooms,
                             attr.bedrooms >= numofbedrooms,
                             attr.beds >= numofbeds
                      )
    return(combinedData)
  }
}

#Funtion to paste required parameters
pasteURL <- function(lat, lng, maxdistance, provider, pagenum) {
  query <- paste0(
    "&latitude=", lat,
    "&longitude=", lng,
    "&maxdistance=", maxdistance,
    "&provider=", provider,
    "&resultsperpage=", 50,
    "&page=", pagenum 
  )
  return(query)
}




