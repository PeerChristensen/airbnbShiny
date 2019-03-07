#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)

df <- read_csv("listings.csv") %>%
  mutate(price = parse_number(price)) %>%
  filter(price < 5000)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("airbnb listings in Copenhagen"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("Slider","Price range:",
                     min = min(df$price),
                     max = max(df$price),
                     value = c(min(df$price),max(df$price)))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("map")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$map <- renderPlot({
      # generate bins based on input$bins from ui.R
      df %>% filter(price >= input$min, price <= input$max) %>%
       ggplot(aes(x=price)) +
       geom_density()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

