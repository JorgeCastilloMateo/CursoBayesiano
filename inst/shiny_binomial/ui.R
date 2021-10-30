# Define UI for application that shows prior, likelihood and posterior
shinyUI(fluidPage(withMathJax(),

    # Application title
    titlePanel("Example: Binomial by Jorge Castillo-Mateo"),
    
    fluidRow(
        column(3,
            helpText(span(strong("Prior"), style = paste0("color:", "salmon")),
                "$$[\\theta] = \\text{Beta}(\\theta \\mid \\alpha,\\, \\beta)$$"
            )
        ),
        
        column(3,
            helpText(span(strong("Likelihood"), style = paste0("color:", "skyblue")),
                "$$[y \\mid \\theta] = \\text{Binomial}(y \\mid n,\\, \\theta)$$"
            )
        ),
        
        column(
            3,
            helpText(span(strong("Posterior"), style = paste0("color:", "purple")),
                "$$[\\theta \\mid y] \\sim \\text{Beta}(\\theta \\mid y + \\alpha,\\, n - y + \\beta)$$"
            )
        )
    ),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("alpha",
                        ("\\(\\alpha\\)"),
                        min = 0,
                        max = 50,
                        value = 1,
                        step = 0.5),
            sliderInput("beta",
                        ("\\(\\beta\\)"),
                        min = 0,
                        max = 50,
                        value = 1,
                        step = 0.5),
            sliderInput("y",
                        ("\\(y\\)"),
                        min = 0,
                        max = 100,
                        value = 5),
            sliderInput("n",
                        ("\\(n\\)"),
                        min = 0,
                        max = 100,
                        value = 10)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
