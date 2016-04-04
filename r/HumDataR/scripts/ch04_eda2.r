# Load libraries

OUTDIR = "../img/ch04/"
dir.create(OUTDIR, FALSE, TRUE)
options(width=70)

############### copy from last time

lengthOfCommute = read.csv("../data/ch03/lengthOfCommute.csv",as.is=TRUE,check.names=FALSE)
lengthOfCommute = as.matrix(lengthOfCommute)
longCommute = lengthOfCommute[,"45m"] + lengthOfCommute[,"60m"] +
              lengthOfCommute[,"90m"]
longCommutePerc = longCommute / lengthOfCommute[,"total"]
hhIncome = read.csv("../data/ch03/hhIncome.csv",as.is=TRUE, check.names=FALSE)
hhIncome = as.matrix(hhIncome)
cumIncome = t(apply(hhIncome[,-1],1,cumsum)) / hhIncome[,1]
meansOfCommute = read.csv("../data/ch03/meansOfCommute.csv",as.is=TRUE,check.names=FALSE)
meansOfCommute = as.matrix(meansOfCommute)
walkPerc = meansOfCommute[,"walk"] / meansOfCommute[,"total"]
carPerc = meansOfCommute[,"car"] / meansOfCommute[,"total"]
bikePerc = meansOfCommute[,"bike"] / meansOfCommute[,"total"]

############### scatter
geodf = read.csv("../data/ch03/geodf.csv", as.is=TRUE)

pdf(paste0(OUTDIR, "simpleScatter.pdf"), 5, 5)
plot(geodf$households, geodf$population)
dev.off()

pdf(paste0(OUTDIR, "simpleScatterLines.pdf"), 5, 5)
plot(geodf$households, geodf$population)
abline(0,1)
abline(0,2)
abline(0,3)
abline(v=median(geodf$households), lty="dashed")
abline(h=median(geodf$population), lty="dashed")
dev.off()

pchVals = rep(19, nrow(geodf))
pchVals[geodf$csa == "Portland"] = 3

cexVals = rep(0.5, nrow(geodf))
cexVals[geodf$csa == "Portland"] = 1

colVals = rep(grey(0.2), nrow(geodf))
colVals[geodf$csa == "Portland"] = grey(0.8)

pdf(paste0(OUTDIR, "incomeScatter.pdf"), 5, 5)
plot(hhIncome[,"50k"]/hhIncome[,"total"],
     hhIncome[,"200k"]/hhIncome[,"total"],
     pch=pchVals,
     cex=cexVals,
     col=colVals)
dev.off()

############### text

county30k = tapply(hhIncome[,"30k"], geodf$county, sum)
county200k = tapply(hhIncome[,"200k"], geodf$county, sum)
countyTotal = tapply(hhIncome[,"total"], geodf$county, sum)
county30k = county30k / countyTotal
county200k = county200k / countyTotal

pdf(paste0(OUTDIR, "incomeScatterCounty.pdf"), 8, 6)
plot(county30k, county200k)
text(county30k, county200k+0.001, names(county30k),cex=0.5)
dev.off()

csaValues = geodf$csa[match(names(county30k), geodf$county)]
csaValues

csaSet = unique(geodf$csa)
index = match(csaValues, csaSet)
index

colVals = c("orchid1","navy","wheat3","olivedrab")
colVals[index]

pdf(paste0(OUTDIR, "incomeScatterCountyCols.pdf"), 8, 6)
plot(county30k, county200k, col=colVals[index], pch=19)
text(county30k, county200k+0.001, names(county30k),col=colVals[index],cex=0.5)
dev.off()

data.frame(csaSet,colVals)


############### points

pdf(paste0(OUTDIR, "redPointsPlot.pdf"), 5, 5)
plot(hhIncome[,"30k"] / hhIncome[,"total"],
     hhIncome[,"200k"] / hhIncome[,"total"],
     col="black",
     pch=19,
     cex=0.5)

index = which(walkPerc > 0.3)

points(hhIncome[index,"30k"] / hhIncome[index,"total"],
       hhIncome[index,"200k"] / hhIncome[index,"total"],
       col="red")
dev.off()


############### line plot
timeOfCommute = read.csv("../data/ch04/timeOfCommute.csv",
                         as.is=TRUE,check.names=FALSE)
timeOfCommute = as.matrix(timeOfCommute)
timeOfCommute[,-1] = timeOfCommute[,-1] / timeOfCommute[,1]
timeOfCommute[1:5,]

numericTimes = c(5,5.5,6,6.5,7,7.5,8,8.5,9,10,11,12,16,24)

pdf(paste0(OUTDIR, "simpleLinePlot.pdf"), 8, 5)
plot(numericTimes, timeOfCommute[1,-1], axes=TRUE,
     xlab="time", ylab="percentage")
lines(numericTimes, timeOfCommute[1,-1])
dev.off()

timeOfCommuteDens = timeOfCommute[,-1]
timeOfCommuteDens[,1] = timeOfCommuteDens[,1] / 5
timeOfCommuteDens[,2:9] = timeOfCommuteDens[,2:9] * 2
timeOfCommuteDens[,13] = timeOfCommuteDens[,13] / 4
timeOfCommuteDens[,14] = timeOfCommuteDens[,14] / 8

pdf(paste0(OUTDIR, "betterLinePlot.pdf"), 8, 5)
plot(numericTimes, timeOfCommuteDens[1,], axes=FALSE,
     xlab="time", ylab="percentage")
lines(numericTimes, timeOfCommuteDens[1,])
box()
axis(2)
axis(1,at=numericTimes, label=colnames(timeOfCommuteDens), las=2)
dev.off()

pdf(paste0(OUTDIR, "aggregateLinePlot.pdf"), 8, 5)
plot(numericTimes, timeOfCommuteDens[1,], type="n", axes=FALSE,
     xlab="time", ylab="density", ylim=c(0,0.4))
for(j in 1:nrow(timeOfCommute)) {
  lines(numericTimes, timeOfCommuteDens[j,],col=rgb(0,0,0,0.01))
}
axis(2)
axis(1,at=numericTimes, label=colnames(timeOfCommuteDens), las=2)

medianTimes = apply(timeOfCommuteDens,2,median)
lines(numericTimes, medianTimes)

q1Times = apply(timeOfCommuteDens,2,quantile,probs=0.25)
lines(numericTimes, q1Times, col=rgb(0,0,0), lty="dashed")

q3Times = apply(timeOfCommuteDens,2,quantile,probs=0.75)
lines(numericTimes, q3Times, col=rgb(0,0,0), lty="dashed")
dev.off()


############### scatter plot matrix

tractData = data.frame(walkPerc, carPerc,
                       inc30k=timeOfCommuteDens[,"7am"],
                       inc200k=hhIncome[,"200k"]/hhIncome[,"total"])

tractData = tractData[apply(is.na(tractData),1,sum) == 0, ]

for (i in 1:5) {
  for (j in 1:5) {
    if (i < j) print(paste(i,":",j))
  }
}

pdf(paste0(OUTDIR, "scatterPlotMatrix.pdf"), 8, 8)
par(mfrow=c(4,4))
par(mar=c(1,1,1,1))
par(oma=c(2,2,2,2))
for (i in 1:ncol(tractData)) {
  for (j in 1:ncol(tractData)) {
    plot(tractData[,j],tractData[,i], pch=19,col=rgb(0,0,0,0.2),
         axes=FALSE)
    box()
    if (i == 1) title(main=colnames(tractData)[j])
    if (i == ncol(tractData)) axis(1)
    if (j == 1) axis(2)
  }
}
dev.off()

############### correlation matrix

corMat = cor(tractData)
round(corMat,2)

pdf(paste0(OUTDIR, "correlationMatrix.pdf"), 5, 5)
par(mar=c(0,0,0,0))
plot(1:ncol(corMat),1:ncol(corMat),type="n",axes=FALSE,
     ylim=c(0.6,ncol(corMat)+0.4),xlim=c(0.6,ncol(corMat)+0.4))

for (i in 1:nrow(corMat)) {
  for (j in 1:ncol(corMat)) {
    if (i!=j) {
      points(i,j,pch=19,col=grey(1-abs(corMat[i,j])), cex=3)
      if (corMat[i,j] > 0) text(i,j,"+",col=grey(abs(corMat[i,j])))
      if (corMat[i,j] < 0) text(i,j,"-",col=grey(abs(corMat[i,j])))
    } else {
      text(i,j,colnames(corMat)[j],cex=0.5)
    }
  }
}
dev.off()




