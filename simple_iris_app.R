# working, simple iris scatterplots


library(tidyverse)
library(shiny)

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
      #   # Select variable for y-axis
    
      selectInput(inputId = "x",
                  label   = "Variable:",
                  choices = c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")),
      
    selectInput(inputId = "y",
                label   = "Variable:",
                choices = c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width"))
    ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "densityplot")
    )
  )
)


# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create the scatterplot object the plotOutput function is expecting
  
  output$densityplot <- renderPlot({
    
      ggplot(data = iris,aes_string(x = input$x,y = input$y)) +
      geom_point()
  })
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)

