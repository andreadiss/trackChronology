library(shiny)
ui = shinyUI(pageWithSidebar( #DIVIDE LO SCHERMO IN 2
  headerPanel("Example"), #DA IL TITOLO ALLA METà DI SN
  sidebarPanel(numericInput(inputId = "number", #DEFINISCE L'INPUT NELLA METà DI SINISTRA
    label = "enter a number",
    value = "50")
  ),
  mainPanel( # SI SPOSTA SULLA METà DI DESTRA
    h3("This is what you entered"), # CI Dà IL TITOLO
    plotOutput(outputId = "histDisplay") #DICE COSA FARE
  )
 ))

server = shinyServer(function (input,output){
  output$histDisplay = renderPlot({
    hist(rnorm(input$number))
  })
})

shinyApp(ui = ui, server = server)
