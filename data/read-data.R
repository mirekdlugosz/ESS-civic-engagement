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

ESS.all <- read.csv("data/ESS1-6e01_0_F1.csv", stringsAsFactors=FALSE)

columns <- match(c("contplt", "wrkprty", "wrkorg", "badge", 
                   "sgnptit", "pbldmn", "bctprd"), 
                 colnames(ESS.all))

count.year <- function(x) {
  # count number of 1's ("yes"'s) in each row
  x$sum <- apply(x[, columns] == 1, 1, sum)
  # compute weighted summary table for each value of scale, i.e.
  # how many people had 0 "yes", how many had 1 "yes" etc
  count <- tapply(x$pspwght, factor(x$sum, levels=0:7), sum)
  count[is.na(count)] <- 0
  data.frame(country=x[1, "cntry"], 
             # overly clever way to translate "1" to 2002, "2" to 2004 etc.
             year=2000 + 2*x[1, "essround"], 
             scale.value=names(count), 
             number=count, 
             percent=round(count/sum(count)*100, 3),
             stringsAsFactors = FALSE)
}

count.country <- function(x) {
  do.call("rbind", 
    by(x, x$essround, count.year))
}

count.all <- function(x) {
  do.call("rbind", 
          by(x, x$cntry, count.country))
}

ESS.data <- count.all(ESS.all)

save(ESS.data, file="data/ESS.Rdata")

# Avoid pollution of global namespace when run from RStudio
rm(ESS.all, ESS.data, columns, count.all, count.country, count.year)