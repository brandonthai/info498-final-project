library(dplyr)
library(plotly)
source('scripts/api_query.r')

build_chart2 <- function(queryData) {
  data <- get_data(queryData)
  summary_room_type <- data %>%
                          group_by(attr.roomType.text) %>%
                          summarise("num_listings" = n())
  
  p <- plot_ly(summary_room_type,
               x = attr.roomType.text,
               y = num_listings,
               type = "bar",
               marker = list(color = '#4297C2')
        ) %>%
        layout(xaxis = list(title = "Room Type"),
               yaxis = list(title = "Number of Listings"),
               title = "Different Types of Rooms"
        )
  return(p)
}







