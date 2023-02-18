library(shiny)
library(palmerpenguins)

ui <- fluidPage(
  sliderInput(inputId = "bill_length", label = "Select the range of bill length?", value = c(40,50), min = 32, max = 60),
  plotOutput("penguin_plot"),
  tableOutput("penguin_table")
  
)
server <- function(input, output){
  
  observe({
      print(input$bill_length)
  })
  
  data <- reactive({
      subset(penguins, bill_length_mm > input$bill_length[1] & bill_length_mm < input$bill_length[2])
  })
  
  output$penguin_plot <- renderPlot({
    plot(data()$bill_depth_mm, data()$bill_length_mm, col = data()$species)
  })
  
  output$penguin_table <- renderTable({
    data()
  })
}

shinyApp(ui, server)
