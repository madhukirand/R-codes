shinyUI(fluidPage(
  titlePanel("senti"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("search a topic for sentiment analysis"),
      
      textInput("search", "Topic","modi")
    ),
    
    mainPanel(
      tabsetPanel(
      tabPanel("Plot",
               plotOutput("bar"),
               plotOutput("pie")
      )
      )
  )
  
)))