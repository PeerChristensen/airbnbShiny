# working, price density plots by room type

library(tidyverse)
library(shiny)

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
      # #   # Select variable for y-axis
      #    sliderInput(inputId = "price",
      #              label   = "Price range:",
      #               min     = min(df$price),
      #               max     = max(df$price),
      #               value = c(min(df$price), max(df$price)))
      #  ,
      selectInput(inputId = "type",
                  label   = "Room type:",
                  choices = c("Entire home/apt", "Private room", "Shared room"))),
    
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
    #output$range <- renderPrint({ input$price })
    
    #data <- df %>%
    #  filter(price %in% output$range)
    df <- read_csv("listings.csv") %>%
      mutate(price = parse_number(price)) %>%
      filter(price < 5000) %>%
      mutate(room_type = as.factor(room_type)) %>%
      select(price,room_type) %>%
      filter(room_type == input$type)
    ggplot(data = df, aes_string(x = df$price)) +
      geom_density()
  })
}


# Create a Shiny app object
shinyApp(ui = ui, server = server)

