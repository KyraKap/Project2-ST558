library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) { 
  output$chapel_hill_plot <- renderPlot(
    #code that will return a plot
  )

})