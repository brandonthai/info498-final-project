library(shiny)
library(leaflet)
library(plotly)

providers <- c("airbnb", "alwaysonvacation", "apartmentsapart",
               "bedycasa", "bookingpal", "citiesreference",
               "edomizil", "geronimo", "gloveler",
               "holidayvelvet", "homeaway", "homestay",
               "hostelworld", "housetrip", "interhome",
               "nflats", "roomorama", "stopsleepgo",
               "theotherhome", "travelmob", "vacationrentalpeople",
               "vaycayhero", "waytostay", "webchalet", "zaranga"
               )


# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    # Application title
    h1("Rental Finder:", align = "center"),
    h3("Discover Your Dream Rental", align = "center"),
    br(),
    fluidRow(
      column(3,
          wellPanel(
            textInput("city", "Enter a city (ie. Seattle):", value = 'Chelan'),
            textInput("state", "Enter a state (ie. WA):", value = 'WA'),
            actionButton("submit", "Search")
          ),
          wellPanel(
            h3("Filter Results"),
            checkboxInput("isinstantbook", label = "Check for Instant Book only", value = FALSE),
            numericInput("guests", label = ("Number of Guests:"), value = 1),
            selectInput("provider", label = ("Select a Provider"), choices = providers),
            sliderInput("numofbathrooms", label = "Number of Bathrooms:", min = 1, max = 10, value = 1, step = 1),
            sliderInput("numofbedrooms", label = "Number of Bedrooms:", min = 0, max = 10, value = 0, step = 1),
            sliderInput("numofbeds", label = "Number of Beds:", min = 1, max = 10, value = 1, step = 1),
            sliderInput("maxdistance", label = "Search Radius (Km):", min = 1, max = 35, value = 5, step = 1)
          )
      ),
      column(9,
          leafletOutput('mymap', height = 700),
          br(),
          column(4, plotlyOutput('mychart')),
          column(4, plotlyOutput('mychart3')),
          column(4, plotlyOutput('mychart2'))
      ),
      column(9,
             br()
      )
    )
  )
)






