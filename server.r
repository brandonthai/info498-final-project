library(shiny)
library(leaflet)
library(Hmisc)
library(plotly)
source('scripts/build_map.r')
source('scripts/build_chart1.r')

shinyServer(function(input, output) {
  # Create a map via your build_map function when submit button is clicked
   displayMap <- eventReactive(input$submit, {
    # Create a Progress object
    progress <- shiny::Progress$new()
    # Make sure it closes when we exit this reactive, even if there's an error
    on.exit(progress$close())
     
    searchMessage <- paste0("Looking for rentals in ", input$city, ", ", input$state,".", " Please Wait...")
     
    progress$set(message = searchMessage)
    return(list(userCity = capitalize(input$city),
                  userState = toupper(input$state)
                  )
             )
  })
  
  # Display the map to UI 
  output$mymap <- renderLeaflet({
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
      #pricemax = input$price[1],
      #pricemin = input$price[2]
    ))
  })
  
  output$mychart <- renderPlotly({
    location <- displayMap()
    
    build_chart(queryData <- list(
      city = location$userCity,
      state = location$userState,
      guests = input$guests,
      provider = input$provider,
      isinstantbook = input$isinstantbook,
      maxdistance = input$maxdistance,
      numofbathrooms = input$numofbathrooms,
      numofbedrooms = input$numofbedrooms,
      numofbeds = input$numofbeds
      #pricemax = input$price[1],
      #pricemin = input$price[2]
    ))
  })
})






