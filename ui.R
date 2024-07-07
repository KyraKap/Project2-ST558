library(shiny) 

ui <- fluidPage(
  navbarPage("Finding the time of Sunrise and Sunset", id = NULL, selected= NULL, position= "static-top", header = "this is my header", inverse=TRUE, fluid=TRUE),

    tabsetPanel(
      tabPanel("About", "contents"),
      tabPanel("Data Download", "contents"),
      tabPanel("Data Exploration", "contents"),
  )
)

