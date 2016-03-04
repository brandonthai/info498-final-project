library(shiny)
library(leaflet)
source('scripts/build_map.r')

shinyServer(function(input, output) {
  # Create a map via your build_map function
    output$mymap <- renderLeaflet({
      build_map(queryData <- list(
        city = input$city,
        state = input$state,
        guests = input$guests,
        isinstantbook = input$isinstantbook,
        maxdistance = input$maxdistance,
        numofbathrooms = input$numofbathrooms,
        numofbedrooms = input$numofbedrooms,
        numofbeds = input$numofbeds,
        pricemax = input$price[1],
        pricemin = input$price[2],
        resultsperpage = input$resultsperpage))
    })
})



