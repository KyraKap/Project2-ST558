library(shiny) 

ui <- fluidPage(
  navbarPage("Finding the time of Sunrise and Sunset", id = NULL, selected= NULL, position= "static-top", header = "this is my header", inverse=TRUE, fluid=TRUE),

    tabsetPanel(
      tabPanel("About", "contents"),
      tabPanel("Data Download", "contents", dateInput("date 1", label = "INSERT DATE HERE", format = "yyyy-mm-dd"), varSelectInput(
        "variable1",
        label = "data for my location",
        chapel_hill_data$sunrise),
        ),
      tabPanel("Data Exploration", "contents"),
      
  
  )
)

