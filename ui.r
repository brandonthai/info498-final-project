library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    # Application title
    titlePanel("Hello Shiny!"),
    fluidRow(
      column(3,
          wellPanel(
            textInput("city", "Enter a city:", value = 'Seattle'),
            textInput("state", "Enter a state:", value = 'WA'),
            actionButton("submit", "Submit")
          ),
          wellPanel(
            h3("Filter Results"),
            checkboxInput("isinstantbook", label = "Check for Instant Book only", value = TRUE),
            numericInput("guests", label = ("Number of Guests:"), value = 1),
            sliderInput("numofbathrooms", "Number of Bathrooms:", min = 1, max = 10, value = 1, step = 1),
            sliderInput("numofbedrooms", "Number of Bedrooms:", min = 1, max = 10, value = 2, step = 1),
            sliderInput("numofbeds", "Number of Beds:", min = 1, max = 10, value = 2, step = 1),
            sliderInput("maxdistance", "Search Radius (Km):", min = 0.01, max = 200, value = 10, step = 5),
            sliderInput("price", "Price Range:", min = 0, max = 1000, value = c(250, 750)),
            selectInput("resultsperpage", label = ("Number of Results:"), choices = list(15, 20, 25, 30, 40, 45, 50), selected = 25)
          )
      ),
      mainPanel(
            plotlyOutput('plot')
      )
    )
  )
)




