library(ggplot2)
library(RColorBrewer)
library(reshape2)
library(grid)
input <- list(
  ESSWaves = 2002,
  unitsType = "Relative units"
  )
load("ESS-Poland.RData")
ESSdata <- ESS.data

# walidacja wejścia ESSWaves
rows <- ESSdata[,2] == input$ESSWaves
if (input$unitsType == "Relative units") {
  valueUnits <- list(column=5, ylim=100, ystep=10, ylab="Percent")
} else {
  valueUnits <- list(column=4, ylim=1700, ystep=100, ylab="Count")
}

x <- ESSdata[rows, valueUnits[["column"]] ]
binNames <- ESSdata[rows, 3]

barplot(x, names.arg = binNames, 
        xlab = "Engagement index (higher is better)",
        ylab = valueUnits[["ylab"]],
        ylim = c(0, valueUnits[["ylim"]]),
        yaxt= "n",
        col = colors, border = 'white')
axis(2, col="#000000",
     lwd=1,
     at=seq(0, valueUnits[["ylim"]], valueUnits[["ystep"]]),
     )

stopifnot(is.na("wyłącz się, proszę"))

tmp <- dcast(ESS.data, point.on.scale ~ year, value.var = "percent")
tmp <- tmp[,-1]
colors <- c("#8C2D04", "#D94801", "#F16913", "#FD8D3C", 
            "#FDAE6B", "#FDD0A2", "#FEE6CE", "#FFF5EB")
par(xpd=TRUE)
plot(c(1,6), c(0,100), type="n",
     xlab="", ylab="",
     yaxt="n", xaxt="n",
     bty="n")
axis(1, col="#000000",
     lwd=1,
     at=1:6,
     pos= -2,
     labels=seq(2002,2012,2))
axis(2, col="#000000",
     lwd=1,
     pos=0.95,
     at=seq(0,100,10),
     labels=seq(0,100, 10))
title(ylab="Percent", mgp=c(1.5,0,0))
for (i in seq(1, (nrow(tmp)))) { 
  perc <- colSums(tmp[i:7,])
  polygon(
    c(seq_along(perc), rev(seq_along(perc))),
    c(perc,rep(0,length(perc))),
    col = colors[i], border=colors[i])
}
legend("bottom", paste(0:7), xpd = TRUE, 
       horiz = TRUE, 
       #inset = c(0, -0.25), 
       inset = c(0, -0.27), 
       bty = "n",
       fill=colors,
       title="Engagement index (higher is better)"
       )

  p <- 
    ggplot(ESS.data, 
           aes(x=year, y=percent, group=point.on.scale,
               order=rev(point.on.scale)
           )) +
    #   theme_bw() +
    #   xlab("Year") + ylab("Percent") + 
    #   scale_x_discrete(expand = c(0,0)) +
    #   scale_y_continuous(expand = c(0,0)) +
#    scale_fill_manual(values=rev(brewer.pal(8, "Oranges"))) +
    geom_area(aes(fill=point.on.scale), position = "stack", linetype=1, size=1, color="white") 
  #  geom_area(color="black")
  
  print(p)

# barplot procentowy
# tmp <- dcast(ESS.data, point.on.scale ~ year, value.var = "percent")
# rownames(tmp) <- tmp[,1] ; tmp <- tmp[,-1]
# barplot(as.matrix(tmp[rev(rownames(tmp),]))

# area chart na defaulcie ggplot
# ggplot(ESS.data, aes(x=year, y=number, group=point.on.scale, fill=point.on.scale)) + geom_area(position = "fill")

# line chart wartości absolutnych
# tmp <- dcast(ESS.data, point.on.scale ~ year, value.var = "number")
# rownames(tmp) <- tmp[,1] ; tmp <- tmp[,-1]
# plot(c(1,6), c(0,2000), type="n")
# lines(seq_along(tmp[1,]), as.integer(tmp[1,]), type="b", col="red")