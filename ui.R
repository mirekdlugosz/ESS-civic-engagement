#    Civic engagement in Europe explorer - R Shiny application
#    Copyright (C) 2015  Mirosław Zalewski <mz@miroslaw-zalewski.eu>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


library("shiny")

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
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  title = "Civic engagement in Europe",
  tags$div(class="container", id="heading",
    h1("Civic engagement in"),
           selectInput("country", NULL, countries, selected = "PL")
  ),
  navbarPage(NULL,
             tabPanel("Overview",
                      overviewPlotUI
                      ),
             tabPanel("Explore data on year basis",
                      yearPlotUi
                      )
  ),
  
  hr(),

  div(id="description",
    includeMarkdown("./description.md")
  ),
  
  singleton(tags$script(type="text/javascript", 
                        src="js/parse_input.js")) 
  
))
