library("shiny")
library("markdown")

plotHeight <- "400px"

overviewPlotUI <- fluidRow(
  column(width=8, offset=2,
    plotOutput("overviewPlot", height = plotHeight)
  )
)

yearPlotUi <- sidebarLayout(
  sidebarPanel(
    # List of years for detailed plot is dynamic - based on selected country
    # (not every country took part in every ESS wave)
    uiOutput("yearRadio"),
    
    radioButtons("unitsType",
                 "Display values in",
                 list("Absolute units" = "number",
                      "Relative units" = "percent"),
                 selected = "percent"
                 )
  ),
  
  mainPanel(
    plotOutput("yearPlot", height=plotHeight),
    tableOutput("yearTable")
  )
)

shinyUI(fluidPage(

  # Application title
  titlePanel("Civic engagement in Poland"), 
  selectInput("country", NULL, countries, selected = "PL"),
  navbarPage(NULL,
             tabPanel("Overview",
                      overviewPlotUI
                      ),
             tabPanel("Explore data on year basis",
                      yearPlotUi
                      )
  ),
  
  hr(),

  includeMarkdown("./description.md")
  
))
