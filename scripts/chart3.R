library(dplyr)
library(plotly)
source('scripts/apiQuery.R')

data <- get_data(queryData)

just_propType <- group_by(data, attr.propType.text) %>%
  summarise("meanofprice" = mean(price.monthly))

plot_ly(just_propType,
        x = attr.propType.text,
        y = meanofprice,
        type = 'bar') %>%
  layout(xaxis = list(title = "Property Type"), yaxis = list(title = "Avg. Price"), 
                      title = "Average Prices for Property Types")