library(dplyr)
library(plotly)
source('scripts/api_query.r')

# function
get_chart3 <- function(queryData) {
  data <- get_data(queryData)
  just_propType <- data %>%
                      group_by(attr.propType.text) %>%
                      summarise("meanofprice" = mean(price.nightly))
  
  p <- plot_ly(just_propType,
               x = attr.propType.text,
               y = meanofprice,
               type = 'bar',
               marker = list(color = '#70318C')
        ) %>%
        layout(xaxis = list(title = "Property Type"),
               yaxis = list(title = "Avg. Price Nightly"),
               title = "Average Nightly Prices for Property Types"
        )
    return(p)
}






