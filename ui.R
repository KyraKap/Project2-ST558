library(shiny) 

ui <- fluidPage(
  
  # top of page - title
  
  navbarPage("Finding the time of Sunrise and Sunset", id = NULL, selected= NULL, position= "static-top", fluid=TRUE,

    sidebarLayout(
      
      sidebarPanel("hello",
                   h3("API Query"),
                   selectInput(capital_cities$Capital.City, "Capital City", capital_cities$Capital.City),
                   sliderInput("bins", "Number of bins:", min=1, max=50, 
                               value=30),
                   textInput("capital_plot", "My Capitals Plot:", value="Histogram")
      ),
      
      mainPanel("hello", width=5)
      
    ),
  
      
    tabsetPanel(
      
      # tab 1 - name of the tab and what it says on the tab
      
      tabPanel("About", "contents"),
      
      # attempting to put plot here
      
      tabPanel("Data Download"
               ),
      tabPanel("Data Exploration", "contents")
    )
  )
)

