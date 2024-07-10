library(shiny) 
library(ggplot2)

# ex 2: UI Code with a plot
#library(shiny)

ui <- fluidPage(
  
  
  titlePanel("Shiny App with Plot"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 20, value = 10),
      textInput("plot_title", "Plot Title:", value = "Histogram")
    ),
    
    mainPanel(
      plotOutput("histPlot")
    )
  )
)

# ex 2: Server Code with a plot
server <- function(input, output, session) {
  output$histPlot <- renderPlot({
    x <- my_subset$sunrise
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = 'darkgray', border = 'white', main = input$plot_title)
  })
}

shinyApp(ui, server)


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
#            ),
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
