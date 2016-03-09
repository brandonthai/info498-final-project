library(dplyr)
library(plotly)
source('scripts/api_query.r')

#Builds chart comparing average nighly price of each property type
build_chart3 <- function(queryData) {
  #Get data frame from API
  data <- get_data(queryData)
  
  if(is.null(nrow(data))) {
    p <- plot_ly(type = 'bar',
                 marker = list(color = '#70318C')
          ) %>%
      layout(xaxis = list(title = "Property Type"),
             yaxis = list(title = "Avg. Price Nightly"),
             title = "Avg. Nightly Prices by Property Types"
      )
    return(p)
  } else {
    #Summarize data frame
    just_propType <- data %>%
                        group_by(attr.propType.text) %>%
                        summarise("meanofprice" = mean(price.nightly))
    
    #Build plot.ly chart
    p <- plot_ly(just_propType,
                 x = attr.propType.text,
                 y = meanofprice,
                 type = 'bar',
                 marker = list(color = '#70318C')
          ) %>%
          layout(xaxis = list(title = "Property Type"),
                 yaxis = list(title = "Avg. Price Nightly"),
                 title = "Avg. Nightly Prices by Property Types"
          )
      return(p)
  }
}








