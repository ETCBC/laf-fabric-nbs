# Load libraries

OUTDIR = "../img/ch03/"
dir.create(OUTDIR, FALSE, TRUE)

############### tables
geodf = read.csv("../data/ch03/geodf.csv", as.is=TRUE)
geodf[1:6,]

tab = table(geodf$county)
tab

tab[order(tab)]

names(tab)[order(tab,decreasing=TRUE)][1:5]

table(geodf$county,geodf$csa)


################# histogram
pdf(paste0(OUTDIR, "histBasic.pdf"), 5, 5)
ppPerHH = geodf$population / geodf$households
hist(ppPerHH)
dev.off()

pdf(paste0(OUTDIR, "histTruncated.pdf"), 5, 5)
hist(ppPerHH[ppPerHH < 5])
dev.off()

pdf(paste0(OUTDIR, "histBreaks.pdf"), 5, 5)
hist(ppPerHH[ppPerHH < 5], breaks=30)
dev.off()

pdf(paste0(OUTDIR, "histBreaksManual.pdf"), 5, 5)
hist(ppPerHH[ppPerHH < 5], breaks=(13:50) / 10)
dev.off()

pdf(paste0(OUTDIR, "histLabels.pdf"), 5, 5)
hist(ppPerHH[ppPerHH < 5], breaks=30,
     col="gray",
     xlab="People per Household",
     ylab="Count",
     main="Household Size by Census Tract - Oregon")
dev.off()

################# quantiles
meansOfCommute = read.csv("../data/ch03/meansOfCommute.csv",as.is=TRUE,check.names=FALSE)
meansOfCommute = as.matrix(meansOfCommute)

walkPerc = meansOfCommute[,"walk"] / meansOfCommute[,"total"] * 100
walkPerc = round(walkPerc)

quantile(walkPerc)

carPerc = meansOfCommute[,"car"] / meansOfCommute[,"total"] * 100
carPerc = round(carPerc)
quantile(carPerc)

(0:10)/10
quantile(walkPerc, prob=(0:10)/10)

cent = quantile(walkPerc,prob=seq(0,1,length.out=100),names=FALSE)
round(cent,1)

coff = quantile(carPerc, prob=0.10)
coff
lowCarUsageFlag = (carPerc < coff)
table(lowCarUsageFlag, geodf$csa)

################# binning

breakPoints = quantile(carPerc, prob=seq(0,1,length.out=11),
                        names=FALSE)
breakPoints

bin = cut(carPerc, breakPoints,labels=FALSE,include.lowest=TRUE)

table(bin, geodf$csa)

bins = cut(ppPerHH[ppPerHH < 5], breaks=(13:47) / 10, labels=FALSE,
            include.lowest=TRUE)
table(bins)

pdf(paste0(OUTDIR, "quantileHist.pdf"), 5, 5)
hist(carPerc, breaks=breakPoints)
dev.off()

################# control flow
hhIncome = read.csv("../data/ch03/hhIncome.csv",as.is=TRUE, check.names=FALSE)
hhIncome = as.matrix(hhIncome)

oneRow = hhIncome[1,-1]
oneRow

cumsum(oneRow)

testOutput = rep(0,10)
for (j in 1:10) {
  testOutput[j] = j
}
testOutput

cumIncome = matrix(0, ncol=ncol(hhIncome)-1, nrow=nrow(hhIncome))
for (j in 1:nrow(hhIncome)) {
  cumIncome[j,] = cumsum(hhIncome[j,-1]) / hhIncome[j,1] * 100
  cumIncome[j,] = round(cumIncome[j,])
}
colnames(cumIncome) = colnames(hhIncome)[-1]

round(cumIncome[1:5,],2)

################# multiple plots

pdf(paste0(OUTDIR, "collectionOfHist.pdf"), 8, 8)
par(mfrow=c(4,4))
for(j in 1:16) {
  hist(hhIncome[,j+1] / hhIncome[,1],
       breaks=seq(0,0.7,by=0.05), ylim=c(0,600))
}
dev.off()

bands = colnames(hhIncome)[-1]
bandNames = paste(bands[-length(bands)],"-",bands[-1], sep="")
bandNames = c(bandNames, "200k+")
bandNames

pdf(paste0(OUTDIR, "collectionOfHistNice.pdf"), 8, 8)
par(mfrow=c(4,4))
par(mar=c(0,0,0,0))
for(j in 1:16) {
  hist(hhIncome[,j+1] / hhIncome[,1],
       breaks=seq(0,0.7,by=0.05), ylim=c(0,600),
       axes=FALSE, main="",xlab="",ylab="",
       col="grey")
  box()
  text(x=0.33,y=500,
   label=paste("Income band:", bandNames[j]))
}
dev.off()

################# aggregate

csaSet = unique(geodf$csa)
popTotal = rep(0, length(csaSet))
names(popTotal) = csaSet

for (j in 1:nrow(geodf)) {
  index = match(geodf$csa[j], csaSet)
  popTotal[index] = popTotal[index] + geodf$population[j]
}
popTotal

csaSet = unique(geodf$csa)
wahTotal = rep(0, length(csaSet))
names(wahTotal) = csaSet
for (csa in csaSet) {
  index = which(geodf$csa == csa)
  wahTotal[csa] = wahTotal[csa] +
                     sum(meansOfCommute[index,"work_at_home"])
}
wahTotal / popTotal

################# applying functions

apply(X=meansOfCommute[1:10,-1],MARGIN=1,FUN=sum)
meansOfCommute[1:10,1]

apply(meansOfCommute,2,sum)

dim(apply(hhIncome[,-1],1,cumsum))
cumIncome = t(apply(hhIncome[,-1],1,cumsum)) / hhIncome[,1]
cumIncome = round(cumIncome * 100)

tapply(X=meansOfCommute[,"work_at_home"],
       INDEX=geodf$csa,
       FUN=sum)
