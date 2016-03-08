library(dplyr)
library(plotly)
source('scripts/api_query.r')

build_chart <- function(queryData) {
  data <- get_data(queryData)
  summary_prop_type <- data %>%
                          group_by(attr.propType.text) %>%
                          summarise("num_listings" = n())
  
  p <- plot_ly(summary_prop_type,
               x = attr.propType.text,
               y = num_listings,
               type = "bar",
               marker = list(color = '#D9042B')
        ) %>%
        layout(xaxis = list(title = "Property Type"),
               yaxis = list(title = "Number of Listings"),
               title = "Different Types of Properties"
        )
  return(p)
}







