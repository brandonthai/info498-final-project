library(dplyr)
library(plotly)
source('scripts/apiQuery.R')

build_chart <- function(queryData) {
  data <- get_data(queryData)
  summary_prop_type <- group_by(data, attr.propType.text) %>%
    summarise("num_listings" = n())
  
  p <- plot_ly(summary_prop_type,
          x = attr.propType.text,
          y = num_listings,
          type = "bar"
  ) %>%
    layout(xaxis = list(title = "Property Type"), yaxis = list(title = "Number of Listings"), title = "Different Types of Properties")
  return(p)
}

