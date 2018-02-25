library(shiny)

shinyServer(function(input, output) {

  mtcars$mpgsp <- ifelse(mtcars$mpg - 25 > 0, mtcars$mpg - 25, 0)
  # Source: comite de la securite routiere
  mtcars$accident <- c(18,19,39,15,10,26,20,32,42,17,16,8,15,10,10,5,16,44,36,40,41,16,20,13,15,34,24,26,33,20,22,52)
  model1 <- lm(accident ~ cyl, data = mtcars)
  model2 <- lm(accident ~ cyl + mpgsp, data = mtcars)

  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(cyl = mpgInput))
  })

  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata = 
              data.frame(cyl = mpgInput,
                         mpgsp = ifelse(mpgInput > 7,
                                        mpgInput * mpgInput, mpgInput*.75)))
  })
  

  output$plot1 <- renderPlot({
    mpgInput <- input$sliderMPG
    
    plot(mtcars$cyl, mtcars$accident, xlab = "Cylinder", 
         ylab = "Accident Rate", bty = "n", pch = 16,
         xlim = c(2, 12), ylim = c(0, 80))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
     model2lines <- predict(model2, newdata = data.frame(
      cyl = 1:12,
        mpgsp = ifelse(1:12 - 8 > 0,
                       1:12 * 1:12, 1:12 * .75)
      ))
     lines(1:12, model2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
  
})

