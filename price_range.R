# working, price range density plots by room type

library(tidyverse)
library(shiny)

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
       #   # Select variable for y-axis
           sliderInput(inputId = "price",
                    label   = "Price range:",
                    min     = 0,
                    max     = 4994,
                    value = c(0, 4994))
        ,
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
    output$range <- renderPrint({ input$price })
    
    df <- read_csv("listings.csv") %>%
      mutate(price = parse_number(price)) %>%
      filter(price < 5000) %>%
      mutate(room_type = as.factor(room_type)) %>%
      select(price,room_type) %>%
      filter(room_type == input$type, price >= min(input$price),price <= max(input$price))
    
    ggplot(data = df, aes(x = price)) +
      geom_density()
  })
}


# Create a Shiny app object
shinyApp(ui = ui, server = server)

