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

load("data/ESS.Rdata")

countries <- unique(ESS.data$country)
# Make countries list display natural language names
names(countries) <- c(
  "Austria",
  "Belgium",
  "Bulgaria",
  "Switzerland",
  "Cyprus",
  "Czech Republic",
  "Germany",
  "Denmark",
  "Estonia",
  "Spain",
  "Finland",
  "France",
  "United Kingdom",
  "Greece",
  "Croatia",
  "Hungary",
  "Ireland",
  "Israel",
  "Iceland",
  "Italy",
  "Lithuania",
  "Luxembourg",
  "Netherlands",
  "Norway",
  "Poland",
  "Portugal",
  "Russia",
  "Sweden",
  "Slovenia",
  "Slovakia",
  "Turkey",
  "Ukraine"
)
# Sort list so they appear in alphabetical order of natural language names
countries <- countries[sort(names(countries))]
