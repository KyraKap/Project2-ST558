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



#my_dataset <- api_query(c("London"), "2024-02-15")

ui <- fluidPage(
  capital_cities <- read.csv("https://gist.githubusercontent.com/ofou/df09a6834a8421b4f376c875194915c9/raw/355eb56e164ddc3cd1a9467c524422cb674e71a9/country-capital-lat-long-population.csv")
  capital_cities$tz <- tz_lookup_coords(capital_cities$Latitude, capital_cities$Longitude)
  
  titlePanel("Kyra's API Query App!"),
  
  sidebarLayout(
    sidebarPanel(
      h3("API Query"),
      selectInput(
        "chosen_cities",
        "Choose cities to plot, and click backspace to remove",
        capital_cities$Capital.City,
        multiple = TRUE
      ),
      # allows users to customize API queries!
      dateInput("user_date","Select Date:", value="2024-01-01"),
      actionButton("query_api","Pull Data!")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("About",
                 h3("Description of this App"),
                 p("This api returns sunrise and sunset data when given latitude and longitude. 
                 In this shiny app, you can go through the tabs and download your own csv file of data 
                 you choose, select variables to appear in the plots, and also create a subset"),
                 p("Data Source: https://sunrise-sunset.org/api"),
                 img(src = "graph1x.png", height = "100px"),
                 
                 verbatimTextOutput("api_data")),
        tabPanel("Download Data",
                 # to allow users to select which variables they want to include in their download
                 selectInput("selected_vars","Please Select Desired Variables", 
                             choices = names(my_dataset),multiple=TRUE),
                 textInput("data_file","Filename:",value="my_data"),
                 downloadButton("download_data","Download csv")),
                
        
        tabPanel("Data Exploration",
                 sliderInput(
                   "bins",
                   "Number of bins:",
                   min = 1,
                   max = 20,
                   value = 10
                 ),
                 textInput("plot_title", "Plot Title:", value = "Histogram"),
                 plotOutput("histPlot")
                 # contingency tables based on user input
                 # my_contingency_table <- table()
                 # user_contingency_table <- reactive(table())
                 
                 #numerical summaries based on user input
                 #my_summary <- summarize()
                 #user_summary <- reactive(summarize())
                 
                 # four plots
                 # scatterplot, histogram, line plot, popsicle plot
                 
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
     }) 
      
    #scatterplot
    output$scatPlot <- renderPlot({
      gplot(api_data,aes(x=as.POSIXct(strptime(sunrise,"%H:%M:%S")),y=as.POSIXct(strptime(sunset,"%H:%M:%S"))))+
         geom_point()
    })
      
      # Downloadable csv of selected dataset ----
      output$downloadData <- downloadHandler(
        filename = function() {
          paste(input$data_file, ".csv", sep = "")
        },
        content = function(file) {
          write.csv(datasetInput(), file, row.names = FALSE)
        }
      )
    
  }
  
  shinyApp(ui, server)
  
  

