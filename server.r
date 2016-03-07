library(shiny)
library(leaflet)
library(Hmisc)
source('scripts/build_map.r')

shinyServer(function(input, output) {
  # Create a map via your build_map function when submit button is clicked
   displayMap <- eventReactive(input$submit, {
    build_map(queryData <- list(
      city = capitalize(input$city),
      state = toupper(input$state),
      guests = input$guests,
      provider = input$provider,
      isinstantbook = input$isinstantbook,
      maxdistance = input$maxdistance,
      numofbathrooms = input$numofbathrooms,
      numofbedrooms = input$numofbedrooms,
      numofbeds = input$numofbeds
      #pricemax = input$price[1],
      #pricemin = input$price[2]
      #resultsperpage = input$resultsperpage,
      #page = input$pagenumber))
    ))
  })
  
  # Display the map to UI 
  output$mymap <- renderLeaflet({
      displayMap()
  })
})





