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

# ESS download wizard was released to public roughly
# 12 hours after this file was created.
# This file is kept only for historical purposes and as
# example of how one can read SPSS's data files in batch.
# For all other purposes, use:
# http://www.europeansocialsurvey.org/downloadwizard/

library(foreign)
ESSWaves <- seq(from=2002, by = 2, length.out = 9)
savFiles <- list.files(path = "~/datasets/European Social Survey/",
                        pattern = ".sav$", 
                        full.names = TRUE, recursive = TRUE,
                        ignore.case = TRUE, include.dirs = TRUE)

ESSData <- data.frame(
  country = character(0),
  year = character(0),
  pointOnScale = character(0),
  number = numeric(0),
  percent = numeric(0)
  )

for (savFile in savFiles) {
  if (nchar(basename(savFile)) != 10) next
  # This heuristic is deemed to fail sooner or later
  country <- substr(basename(savFile), 5, 6)
  year <- ESSWaves[ as.numeric(substr(basename(savFile), 4, 4)) ]
  
  fileData <- read.spss(file = savFile,
                        to.data.frame = TRUE,
                        use.value.labels = FALSE)
  fileData <- fileData[, c("contplt", "wrkprty", "wrkorg", "badge",
                           "sgnptit", "pbldmn", "bctprd")]
  
  fileData$sum <- apply((fileData == 1), 1, sum)
  tmp <- summary(factor(fileData$sum, levels=seq(0,7) ))[-9]
  yearData <- data.frame(
    matrix(rep(c(country, year), each = length(tmp)), ncol=2),
    names(tmp),
    tmp,
    tmp/sum(tmp) * 100
  )
  rownames(yearData) <- NULL
  colnames(yearData) <- colnames(ESSData)
  
  ESSData <- rbind(ESSData, yearData)
  
  rm(fileData, tmp, yearData)
  gc()
}

save(ESSData, file="ESS-Poland.RData", ascii = TRUE, compress = FALSE)
