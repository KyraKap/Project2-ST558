library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) { 
  output$chapel_hill_plot <- renderPlot(
    #code that will return a plot
    ggplot(chapel_hill_data, aes(x = chapel_hill_data$day_length,y = chapel_hill_data$sunrise)) + geom_point()
  )

})