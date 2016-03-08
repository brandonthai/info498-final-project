library(dplyr)
library(plotly)
source('scripts/api_query.r')

#Builds chart showing number of listings per room type
build_chart2 <- function(queryData) {
  #Get data frame from API
  data <- get_data(queryData)
  
  if(is.null(nrow(data))) {
    p <- plot_ly(type = "bar",
                 marker = list(color = '#4297C2')
          ) %>%
      layout(xaxis = list(title = "Room Type"),
             yaxis = list(title = "Number of Listings"),
             title = "Types of Rooms Available"
      )
    return(p)
  } else {
    #Summarize data frame
    summary_room_type <- data %>%
                            group_by(attr.roomType.text) %>%
                            summarise("num_listings" = n())
    
    #Build plot.ly chart
    p <- plot_ly(summary_room_type,
                 x = attr.roomType.text,
                 y = num_listings,
                 type = "bar",
                 marker = list(color = '#4297C2')
          ) %>%
          layout(xaxis = list(title = "Room Type"),
                 yaxis = list(title = "Number of Listings"),
                 title = "Types of Rooms Available"
          )
    return(p)
  }
}








