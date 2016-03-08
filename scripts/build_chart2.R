library(dplyr)
library(plotly)
source('scripts/apiQuery.R')

build_chart2 <- function(queryData) {
  data <- get_data(queryData)
  summary_room_type <- group_by(data, attr.roomType.text) %>%
    summarise("num_listings" = n())
  
  p <- plot_ly(summary_room_type,
               x = attr.roomType.text,
               y = num_listings,
               type = "bar"
  ) %>%
    layout(xaxis = list(title = "Room Type"), yaxis = list(title = "Number of Listings"), title = "Different Types of Rooms")
  return(p)
}
