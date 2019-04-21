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
                  choices = municipality),
      
      sliderInput("alpha", "Alpha:",
                  min = 0, max = 1,
                  value = 0.1, step = 0.1)
      ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create the scatterplot object the plotOutput function is expecting
  
  output$scatterplot <- renderPlot({
    #output$range <- renderPrint({ input$price })
    
    #data <- df %>%
    #  filter(price %in% output$range)
    df <- read_csv("avm_all.csv") %>%
      select(estprice,lastprice) %>%
      filter(MUNI_NAME == input$muni)
    
    ggplot(data = df, aes(x = df$estprice,y = df$lastprice)) +
      geom_point(colour = "steelblue", alpha = input$alpha) +
      ggtitle(as.character(input$muni))
      
  })
}


# Create a Shiny app object
shinyApp(ui = ui, server = server)


# adding correlation
# Outputs
# mainPanel(
#   plotOutput(outputId = "scatterplot"),
#   textOutput(outputId = "correlation")
# )
# )
# )
# 
# # Server
# server <- function(input, output) {
#   
#   # Create scatterplot object the plotOutput function is expecting
#   output$scatterplot <- renderPlot({
#     ggplot(data = movies, aes_string(x = input$x, y = input$y)) +
#       geom_point()
#   })
#   
#   # Create text output stating the correlation between the two ploted 
#   output$correlation <- renderText({
#     r <- round(cor(movies[, input$x], movies[, input$y], use = "pairwise"), 3)
#     paste0("Correlation = ", r, ". Note: If the relationship between the two variables is not linear, the correlation coefficient will not be meaningful.")
#   })
}

