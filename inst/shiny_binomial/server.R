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
        ggplot2::ggplot(data, ggplot2::aes(x)) + 
            ggplot2::geom_area(ggplot2::aes(y = prior), fill = "salmon", alpha=0.6) +
            ggplot2::geom_area(ggplot2::aes(y = likelihood), fill = "skyblue", alpha=0.6) +
            ggplot2::geom_area(ggplot2::aes(y = posterior), fill = "purple", alpha=0.6) +
            ggplot2::geom_line(ggplot2::aes(x, prior, color = "prior"), size = 2) +
            ggplot2::geom_line(ggplot2::aes(x, likelihood, color = "likelihood"), size = 2) +
            ggplot2::geom_line(ggplot2::aes(x, posterior, color = "posterior"), size = 2) + 
            ggplot2::theme(legend.position = "bottom") +
            ggplot2::scale_color_manual(name = "Density:", values = c("salmon", "skyblue", "purple"), breaks = c("prior", "likelihood", "posterior")) +
            ggplot2::xlab(expression(theta)) + ggplot2::ylab(NULL) +
            ggplot2::theme_bw() + ggplot2::theme(text = ggplot2::element_text(size = 20))
    })

})
