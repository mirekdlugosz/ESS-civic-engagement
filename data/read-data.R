ESS.all <- read.csv("data/ESS1-6e01_0_F1.csv", stringsAsFactors=FALSE)

columns <- match(c("contplt", "wrkprty", "wrkorg", "badge", 
                   "sgnptit", "pbldmn", "bctprd"), 
                 colnames(ESS.all))

count.year <- function(x) {
  # count number of 1's ("yes"'s) in each row
  x$sum <- apply(x[, columns] == 1, 1, sum)
  # compute summary table for each value of scale, i.e.
  # how many people had 0 "yes", how many had 1 "yes" etc
  # `[-9]` is to drop any NAs that might appear
  count <- summary(factor(x$sum, levels = 0:7))[-9]
  
  data.frame(country=x[1, "cntry"], 
             # overly clever way to translate "1" to 2002, "2" to 2004 etc.
             year=2000 + 2*x[1, "essround"], 
             scale.value=names(count), 
             number=count, 
             percent=count/sum(count)*100,
             stringsAsFactors = FALSE)
}

count.country <- function(x) {
  do.call("rbind", 
    by(x, x$essround, count.year))
}

ESS.data <- do.call("rbind", 
                    by(ESS.all, ESS.all$cntry, count.country))

save(ESS.data, file="data/ESS.Rdata")

# Avoid pollution of global namespace when run from RStudio
rm(ESS.all, ESS.data, columns, count.country, count.year)