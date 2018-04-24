library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define UI for miles per gallon app ----
ui <- fluidPage(
  titlePanel("Miles Per Gallon"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                   "Transmission" = "am",
                    "Gears" = "gear")),
      checkboxInput("outliers", "Show outliers", TRUE)
    ),
    mainPanel(
      h3(textOutput("caption")),
      plotOutput("mpgPlot")
                )
  )
)

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
    formulaText <- reactive({
      paste("mpg ~", input$variable)
    })
  output$caption <- renderText({
        formulaText()
      })
  
# Generate a plot of the requested variable against mpg ----
    output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers,
            col = "#75AADB", pch = 19)
  })
}

# Create Shiny app ----
shinyApp(ui, server)
