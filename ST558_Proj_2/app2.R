library(shiny) 
library(ggplot2)

# ex 2: UI Code with a plot
#library(shiny)


ui <- fluidPage(
  titlePanel("Kyra's Sunrise App"),
  
  sidebarLayout(
    sidebarPanel(
      h3("API Query"),
      selectInput(
        "chosen_cities",
        "Choose cities to plot, select and backspace to remove",
        paste0(capital_cities$Capital.City, " (", capital_cities$Country, ")"),
        multiple = TRUE
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("About"),
        tabPanel("Download Data"),
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















# 
# ui2 <- fluidPage(titlePanel(h3("Kyra's Sunrise App"), ), sidebarLayout(
#   sidebarPanel(
#     "hello",
#     
#     h3("API Query"),
#     selectInput(
#       "chosen_cities",
#       "Choose cities to plot, select and backspace to remove",
#       paste0(capital_cities$Capital.City, " (", capital_cities$Country, ")"),
#       multiple = TRUE
#     ),
#     #dateInput("chosen_Date", "Choose a date", paste0(capital_cities$Capital.City, " (", capital_cities$Country,")"), multiple=TRUE)
#   ),
#   
#   mainPanel(# Panel of TABS
#     
#     tabsetPanel(
#       h3("Tabs for querying the API"),
#       
#       # tab 1
#       
#       tabPanel(h3("About"), # include necessary info here), # tab 2),
#                tabPanel(h3("Data Download"), "create button here for download csv", ),
#                # tab 3
#                tabPanel(
#                  h3("Data Exploration"),
#                  "place plots here that are interactive?",
#                  plotOutput("hist_plot"),
#                  sliderInput(
#                    "bins",
#                    "Number of bins:",
#                    min = 1,
#                    max = 20,
#                    value = 10
#                  ),
#                  textInput("plot_title", "Plot Title:", value = "Histogram")
#                ),
#                
#       )
#     )
#     
#     
#   )
# )
  
  

  # ex 2: Server Code with a plot
  server <- function(input, output, session) {
    output$histPlot <- renderPlot({
      x <- my_subset$sunrise
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      ggplot(my_subset, aes(x=sunrise)) +
        geom_histogram(bins=input$bins) +
        ggtitle(input$plot_title)
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
