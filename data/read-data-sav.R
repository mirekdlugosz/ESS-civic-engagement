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
