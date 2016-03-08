library(shiny)
library(leaflet)
library(Hmisc)
library(plotly)
source('scripts/build_map.r')
source('scripts/build_chart1.r')
source('scripts/build_chart2.r')
source('scripts/build_chart3.r')

shinyServer(function(input, output) {
  # Create a map via your build_map function when submit button is clicked
   displayMap <- eventReactive(input$submit, {
    # Create a Progress object
    progress <- shiny::Progress$new()
    # Make sure it closes when we exit this reactive, even if there's an error
    on.exit(progress$close())
    
    #Loading message displayed when user searches for a location
    searchMessage <- paste0("Looking for rentals in ", input$city, ", ", input$state,".", " Please Wait...")
    progress$set(message = searchMessage)
    
    #Returns the city and state the user searched for in the correct format
    return(list(userCity = capitalize(input$city), userState = toupper(input$state)))
  })
  
  #Display the map to the UI 
  output$map <- renderLeaflet({
    location <- displayMap()
    
    build_map(queryData <- list(
      city = location$userCity,
      state = location$userState,
      guests = input$guests,
      provider = input$provider,
      isinstantbook = input$isinstantbook,
      maxdistance = input$maxdistance,
      numofbathrooms = input$numofbathrooms,
      numofbedrooms = input$numofbedrooms,
      numofbeds = input$numofbeds
    ))
  })
  
  #Display chart1 to the UI
  output$chart <- renderPlotly({
    location <- displayMap()
    
    build_chart1(queryData <- list(
      city = location$userCity,
      state = location$userState,
      guests = input$guests,
      provider = input$provider,
      isinstantbook = input$isinstantbook,
      maxdistance = input$maxdistance,
      numofbathrooms = input$numofbathrooms,
      numofbedrooms = input$numofbedrooms,
      numofbeds = input$numofbeds
    ))
  })
  
  #Display chart2 to the UI
  output$chart2 <- renderPlotly({
    location <- displayMap()
    
    build_chart2(queryData <- list(
      city = location$userCity,
      state = location$userState,
      guests = input$guests,
      provider = input$provider,
      isinstantbook = input$isinstantbook,
      maxdistance = input$maxdistance,
      numofbathrooms = input$numofbathrooms,
      numofbedrooms = input$numofbedrooms,
      numofbeds = input$numofbeds
    ))
  })
  
  #Display chart3 to the UI
  output$chart3 <- renderPlotly({
    location <- displayMap()
    
    build_chart3(queryData <- list(
      city = location$userCity,
      state = location$userState,
      guests = input$guests,
      provider = input$provider,
      isinstantbook = input$isinstantbook,
      maxdistance = input$maxdistance,
      numofbathrooms = input$numofbathrooms,
      numofbedrooms = input$numofbedrooms,
      numofbeds = input$numofbeds
    ))
  })
})