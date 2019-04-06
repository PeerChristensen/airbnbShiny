# working, price density plots by zip code

library(tidyverse)
library(shiny)
library(ggthemes)

df  <- read_csv("avm_all.csv") 
municipality <- df %>% pull(MUNI_NAME) %>% factor()

# Define UI for application that plots features of movies
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
      selectInput(inputId = "muni",
                  label   = "Municipality:",
                  choices = municipality)),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "scatterplot")
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
    df <- read_csv("avm_all.csv") %>%
      select(estprice,lastprice) %>%
      filter(MUNI_NAME == input$muni)
    
    ggplot(data = df, aes(x = df$estprice,y = df$lastprice)) +
      geom_point(colour = "steelblue", alpha = .01) +
      
  })
}


# Create a Shiny app object
shinyApp(ui = ui, server = server)

