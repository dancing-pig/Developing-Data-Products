# Shiny UI code
## Construct the UI part of MpgPrecition app. The user needs to
## input am and cyl, and select a predictive model.
shinyUI(pageWithSidebar(
    headerPanel("Miles/gallon prediction"),
    sidebarPanel(
        ## Instruction
        h5("This app is used to predict mpg according to am and cyl."),
        h5("There are two predictive models you can select."),
        h5("For model1, you need to provide am, 
           and for model2, you need to input am and cyl."),
        
        ## Input field
        numericInput('am', 'transmission (0 = automatic, 1 = manual)', 
                     0, min = 0, max = 1, step = 1),
        numericInput('cyl', 'number of cylinders', 4 , 
                     min = 4, max = 8, step = 2),
        checkboxGroupInput("model", "Checkbox",
                           c("Model mpg ~ as.factor(am) - 1" = "1",
                             "Model mpg ~ as.factor(am) + cyl - 1" = "2"))
    ),
    mainPanel(
        ## Results
        h3('Your slection'),
        h4('transmission entered'),
        verbatimTextOutput("out_am"),
        h4('model selected'),
        verbatimTextOutput("out_model"),
        h4('cyl input'),
        verbatimTextOutput("out_cyl"),
        h4('predictive mpg'),
        verbatimTextOutput("out_mpg")
    )
))