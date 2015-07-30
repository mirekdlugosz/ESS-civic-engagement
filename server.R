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
library("dichromat")
library("ggplot2")
library("RColorBrewer")

colors <- rev(brewer.pal(8, "YlOrBr"))

nearest.multiple <- function(x, multiple) {
  ceiling(x / multiple) * multiple
}

makeOverviewPlot <- function(data.subset) {
  p <- ggplot(data.subset) + 
    geom_bar(stat="identity", 
             aes(x=as.factor(year), y=percent, fill=scale.value, 
                 order=rev(scale.value))) +
    theme_minimal() +
    theme(legend.position = "bottom", axis.ticks.x = element_blank() ) +
    labs(x="Year", y="Percent") +
    guides(fill = guide_legend(title.position="top",
                               title="Engagement index (higher is better)",
                               title.hjust=0.5)) +
    scale_fill_manual(values = colors)
  return(p)
}

makeYearPlot <- function(country.data, year, units) {
  ypmax <- ifelse(units == "number",
                  nearest.multiple(max(country.data$number), 500),
                  100)
  
  p <- ggplot(country.data[country.data$year == year, ]) + 
    geom_bar(stat="identity", aes_string(x="scale.value", 
                                         y=units),
             fill=colors[1]) +
    theme_minimal() + 
    ylim(0, ypmax) +
    labs(x="Engagement index (higher is better)", 
         y=paste0(toupper(substr(units, 1, 1)), substring(units, 2)))
  return(p)
}

shinyServer(function(input, output) {
  
  country.data <- reactive({
    ESS.data[ESS.data$country == input$country, ]
    })
  
  output$yearRadio <- renderUI({
    radioButtons("year", 
                 "Select a year",
                 unique(country.data()$year))
  })
  
  output$overviewPlot <- renderPlot({makeOverviewPlot(country.data())})
  
  output$yearPlot <- renderPlot({makeYearPlot(country.data(),
                                              input$year,
                                              input$unitsType)})
})
