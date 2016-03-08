library(dplyr)
library(plotly)
source('scripts/api_query.r')

#Builds chart showing number of listings per property type
build_chart1 <- function(queryData) {
  #Get data frame from API
  data <- get_data(queryData)
  
  if(is.null(nrow(data))) {
    p <- plot_ly(type = "bar",
                 marker = list(color = '#D9042B')
          ) %>%
      layout(xaxis = list(title = "Property Type"),
             yaxis = list(title = "Number of Listings"),
             title = "Types of Properties Available"
      )
    return(p)
  } else {
    #Summarize data frame
    summary_prop_type <- data %>%
                            group_by(attr.propType.text) %>%
                            summarise("num_listings" = n())
    
    #Build plot.ly chart
    p <- plot_ly(summary_prop_type,
                 x = attr.propType.text,
                 y = num_listings,
                 type = "bar",
                 marker = list(color = '#D9042B')
          ) %>%
          layout(xaxis = list(title = "Property Type"),
                 yaxis = list(title = "Number of Listings"),
                 title = "Types of Properties Available"
          )
    return(p)
  }
}








