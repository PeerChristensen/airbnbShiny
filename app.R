# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    http://shiny.rstudio.com/
# #
# 
# library(tidyverse)
# library(shiny)
# 
# df <- read_csv("listings.csv") %>%
#   mutate(price = parse_number(price)) %>%
#   filter(price < 5000) %>%
#   select(price)
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#    
#    # Application title
#    titlePanel("airbnb listings in Copenhagen"),
#    
#    # Sidebar with a slider input for price range
#    sidebarLayout(
#       sidebarPanel(
#          sliderInput(inputId = "price",
#                      label   = "Price range:",
#                      min     = min(df$price),
#                      max     = max(df$price),
#                      value = c(min(df$price), max(df$price)))
#       ),
#       
#       # Show a plot of the generated distribution
#       mainPanel(
#          plotOutput(outputId = "densityPlot")
#       )
#    )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#    
#    output$densityPlot <- renderPlot({
#      
#       # generate bins based on input$bins from ui.R
#       #df %>% filter(price >= input$min, price <= input$max) %>%
#        ggplot(data=df,aes(x=input$price)) +
#        geom_density()
#    })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)


#from datacamp

library(shiny)
library(ggplot2)
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/course_4850/datasets/movies.Rdata"))

# Define UI for application that plots features of movies
ui <- fluidPage(

  # Sidebar layout with a input and output definitions
  sidebarLayout(

    # Inputs
    sidebarPanel(

      # Select variable for y-axis
      selectInput(inputId = "y",
                  label = "Y-axis:",
                  choices = c("IMDB rating"          = "imdb_rating",
                              "IMDB number of votes" = "imdb_num_votes",
                              "Critics score"        = "critics_score",
                              "Audience score"       = "audience_score",
                              "Runtime"              = "runtime"),
                  selected = "audience_score"),

      # Select variable for x-axis
      selectInput(inputId = "x",
                  label = "X-axis:",
                  choices = c("IMDB rating"          = "imdb_rating",
                              "IMDB number of votes" = "imdb_num_votes",
                              "Critics score"        = "critics_score",
                              "Audience score"       = "audience_score",
                              "Runtime"              = "runtime"),
                  selected = "critics_score"),

      # Select variable for color
      selectInput(inputId = "z",
                  label = "Color by:",
                  choices = c("Title type" = "title_type",
                              "Genre" = "genre",
                              "MPAA rating" = "mpaa_rating",
                              "Critics rating" = "critics_rating",
                              "Audience rating" = "audience_rating"),
                  selected = "mpaa_rating")
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
    ggplot(data = movies, aes_string(x = input$x, y = input$y,
                                     color = input$z)) +
      geom_point()
  })
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)

