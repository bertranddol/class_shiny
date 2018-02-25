library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Accident Rate from Gear"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderMPG", "Number of Cylinder?", 2, 12, value = 6),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predict Accident base on Gear size only (Model 1)"),
      textOutput("pred1"),
      h3("Predict Accident base on Gear size with sport like features (Model 2)"),
      textOutput("pred2")
    )
  )
))