library(shiny) 
library(ggplot2)
library(httr)
library(jsonlite)
library(tidyr)
library(shinydashboard)
library(DT)
library(shiny)
library(caret)
library(dplyr)
library(ggplot2)
library(lubridate)
library(lutz)
library(chron)
library(hms)
library(Hmisc)

source("app_functions.R")

# ex 2: UI Code with a plot
#library(shiny)
capital_cities <- read.csv("https://gist.githubusercontent.com/ofou/df09a6834a8421b4f376c875194915c9/raw/355eb56e164ddc3cd1a9467c524422cb674e71a9/country-capital-lat-long-population.csv")
capital_cities$tz <- tz_lookup_coords(capital_cities$Latitude, capital_cities$Longitude)

my_dataset <- api_query(c("London"), "2024-02-15")


ui <- fluidPage(
  titlePanel("Kyra's Sunrise App"),
  
  sidebarLayout(
    sidebarPanel(
      h3("API Query"),
      selectInput(
        "chosen_cities",
        "Choose cities to plot, select and backspace to remove",
        capital_cities$Capital.City,
        multiple = TRUE
      ),
      dateInput("user_date","Select Date:", value="2024-01-01"),
      actionButton("query_api","Pull Data!")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("About",
                 verbatimTextOutput("api_data")),
        tabPanel("Download Data",
                 selectInput("selected_vars","Please Select Desired Variables", 
                             choices = names(output)),
                 textInput("data_file","Filename:",value="my_data"),
                 downloadButton("download_data","Download csv")),
        tabPanel("Plot",
                 sliderInput(
                   "bins",
                   "Number of bins:",
                   min = 1,
                   max = 20,
                   value = 10
                 ),
                 textInput("plot_title", "Plot Title:", value = "Histogram"),
                 plotOutput("histPlot")
                 )
      )
    )
  )
)











  # ex 2: Server Code with a plot
  server <- function(input, output, session) {
    #query api
    api_data <- eventReactive(input$query_api, {
      cities <- reactive({input$chosen_cities})
      api_query(chosen_cities = cities,chosen_date = user_date)
    }
    )
    
    #histogram
    output$histPlot <- renderPlot({
      x <- api_data$sunrise
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      ggplot(my_subset, aes(x=sunrise)) +
        geom_histogram(bins=input$bins) +
        ggtitle(input$plot_title)
      
      # Downloadable csv of selected dataset ----
      output$downloadData <- downloadHandler(
        filename = function() {
          paste(input$data_file, ".csv", sep = "")
        },
        content = function(file) {
          write.csv(datasetInput(), file, row.names = FALSE)
        }
      )
    })
  }
  
  shinyApp(ui, server)
  
  
  # Scatter Plot
  # gplot(my_subset,aes(x=as.POSIXct(strptime(sunrise,"%H:%M:%S")),y=as.POSIXct(strptime(sunset,"%H:%M:%S"))))+
    # geom_point()
  
  # # top of page - title
  #
  # navbarPage("Finding the time of Sunrise and Sunset", id = NULL, selected= NULL, position= "static-top", fluid=TRUE,
  #
  #            sidebarLayout(
  #
  #              sidebarPanel("hello",
  #
  #                           h3("API Query"),
  #                           selectInput(capital_cities$Capital.City, "Capital City", capital_cities$Capital.City),
  #                           sliderInput("bins", "Number of bins:", min=1, max=50,
  #                                       value=30),
  #                           textInput("capital_plot", "My Capitals Plot:", value="Histogram")
  #              ),
  #
  #              mainPanel("hello", width=5)
  #
  #           ),
  #
  #
  #            tabsetPanel(
  #
  #              # tab 1 - name of the tab and what it says on the tab
  #
  #              tabPanel("About",
  #                       # attempting to put plot here
  #                       plotOutput("hist_plot")
  #
  #              ),
  #
  #
  #
  #              tabPanel("Data Download"
  #              ),
  #              tabPanel("Data Exploration", "contents")
  #            )
  # )
  # )
  
  # shinyServer(function(input, output, session) {
  #   output$chapel_hill_plot <- renderPlot(
  #     #code that will return a plot
  #   )
  #
  #   #histogram
  #   output$hist_plot <- renderPlot({
  #     hist(my_subset$sunrise, breaks = bins, col = 'darkgray', border = 'white', main = input$plot_title)
  #
  #   })
  #
  # })
