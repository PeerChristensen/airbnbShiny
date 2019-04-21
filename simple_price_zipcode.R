# working, price density plots by zip code

library(tidyverse)
library(shiny)

# df  <- read_csv("listings.csv") 
# zip <- df %>% group_by(zipcode) %>% count() %>% filter(n >= 100) %>% drop_na() %>% pull(zipcode) %>% factor()

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(

      selectInput(inputId = "zipcode",
                  label   = "Zip code:",
                  choices = zip)),
    
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
    df  <- read_csv("listings.csv") 
    zip <- df %>% group_by(zipcode) %>% count() %>% filter(n >= 100) %>% drop_na() %>% pull(zipcode) %>% factor()

    df <- df %>%
      mutate(price = parse_number(price),
             zipcode = factor(zipcode)) %>%
      filter(price < 5000) %>%
      select(price,zipcode) %>%
      filter(zipcode == input$zipcode)

    ggplot(data = df, aes_string(x = df$price)) +
      geom_density()
  })
}


# Create a Shiny app object
shinyApp(ui = ui, server = server)

