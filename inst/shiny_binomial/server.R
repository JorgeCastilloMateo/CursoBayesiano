#
# This is the server logic of a Shiny web application. You can run the
library(shiny)

# Define server logic required to plot the densities
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        grid <- seq(0.001, 0.999, 0.001)
        data <- data.frame(x = grid, 
                           prior = dbeta(grid, input$alpha, input$beta),
                           likelihood = dbeta(grid, input$y + 1, input$n - input$y + 1),
                           posterior = dbeta(grid, input$y + input$alpha, input$n - input$y + input$beta))

        # draw the densities
        ggplot(data, aes(x)) + 
            geom_area(aes(y = prior), fill = "salmon", alpha=0.6) +
            geom_area(aes(y = likelihood), fill = "skyblue", alpha=0.6) +
            geom_area(aes(y = posterior), fill = "purple", alpha=0.6) +
            geom_line(aes(x, prior, color = "prior"), size = 2) +
            geom_line(aes(x, likelihood, color = "likelihood"), size = 2) +
            geom_line(aes(x, posterior, color = "posterior"), size = 2) + 
            ggplot2::theme(legend.position = "bottom") +
            scale_color_manual(name = "Densidad:", values = c("salmon", "skyblue", "purple"), breaks = c("prior", "likelihood", "posterior")) +
            xlab(expression(theta)) + ylab(NULL) +
            ggplot2::theme_bw() + theme(text = element_text(size = 20))
    })

})
