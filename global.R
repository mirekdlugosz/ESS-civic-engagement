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