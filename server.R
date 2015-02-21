# Shiny server code
## Construct two predictive models to predict mpg, 
## according to user's input of am and cyl.

library(shiny)
data(mtcars)

## Predictive model 1, no cyl.
model1 <- function(am, model) {
    fit <- lm(mpg ~ as.factor(am) - 1, data = mtcars)
    ret <- coef(fit)[1] * (1 - am) + coef(fit)[2] * am
    names(ret) <- NULL
    print(ret)
}

## Predictive model 2, which has cyl.
model2 <- function(am, cyl, model) {
    fit <- lm(mpg ~ as.factor(am) + cyl - 1, data = mtcars)
    ret <- coef(fit)[1] * (1 - am) + coef(fit)[2] * am + coef(fit)[3] * cyl
    names(ret) <- NULL
    print(ret)
}

## Predict mpg according to model selection
predictMpg <- function(am, cyl, model) {
    if ("1" %in% model && "2" %in% model) {
        model1(am, model)
        model2(am, cyl, model)
    }
    else if ("1" %in% model) {
        model1(am, model)
    }
    else if ("2" %in% model) {
        model2(am, cyl, model)
    }
    else {
        NULL
    }
}

## Main code in server part
shinyServer(
    function(input, output) {
        output$out_am <- renderPrint({input$am})
        output$out_cyl <- renderPrint({input$cyl})
        output$out_model <- renderPrint({input$model})
        output$out_mpg <- renderPrint({predictMpg(input$am, input$cyl, input$model)})
    }
)