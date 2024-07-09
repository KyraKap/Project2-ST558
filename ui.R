library(shiny) 

ui <- fluidPage(
  
  # top of page - title
  
  navbarPage("Finding the time of Sunrise and Sunset", id = NULL, selected= NULL, position= "static-top", fluid=TRUE),

    sidebarLayout(
      
      sidebarPanel("hello"),
        
      )
    )
  
    # panel of tabs across the top
# _______________________________________ 
    tabsetPanel(
      
      # tab 1 - name of the tab and what it says on the tab
      
      tabPanel("About", "contents"),
      
      # attempting to put plot here
      
        plotOutput("chapel_hill_plot"), 
      
      tabPanel("Data Download", "contents", dateInput("date 1", label = "INSERT DATE HERE", format = "yyyy-mm-dd"), varSelectInput(
        "variable1", label = "data for my location", chapel_hill_data$sunrise),
      
      tabPanel("Data Exploration", "contents"),
      
      # Create a spot for the plot
      
      ),
      
    mainPanel(
         
      )
  )
# _______________________________________ 
)

