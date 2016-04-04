# Load libraries
library(colorspace)

OUTDIR = "../img/ch05/"
dir.create(OUTDIR, FALSE, TRUE)
options(width=70)

############### copy from last time

#http://eed.nsd.uib.no/webview/index.jsp?study=http%3A%2F%2F129.177.90.166%3A80%2Fobj%2FfStudy%2FFRPR2012&mode=cube&v=2&cube=http%3A%2F%2F129.177.90.166%3A80%2Fobj%2FfCube%2FFRPR2012_C1&top=yes

# ARTHAUD (LO) - Nathalie Arthaud - Workers Struggle (Lutte Ouvrière)
# POUTOU (NPA) - Philippe Poutou - New Anticapitalist Party (Nouveau Parti anticapitaliste)
# MELENCHON (FDG) - Jean-Luc Mélenchon - Left Front (Front de gauche)
# HOLLANDE (PS) - François Hollande - Socialist Party (Parti socialiste)
# JOLY (EELV) - Eva Joly - Europe Écologie–The Greens (Europe Écologie–Les Verts)
# BAYROU (MODEM) - François Bayrou - Democratic Movement (Mouvement démocrate)
# SARKOZY (UMP) - Nicolas Sarkozy - Union for a Popular Movement (Union pour un mouvement populaire)
# DUPONT-AIGNAN (DLR) - Nicolas Dupont-Aignan - Arise the Republic (Debout la République)
# LE PEN (FN) - Marine Le Pen - National Front (Front national)
# CHEMINADE (SP) - Jacques Cheminade - Solidarity and Progress (Solidarité et Progrès)

################# box plot
geodf = read.csv("../data/ch03/geodf.csv", as.is=TRUE)
lengthOfCommute = read.csv("../data/ch03/lengthOfCommute.csv",as.is=TRUE,check.names=FALSE)
lengthOfCommute = as.matrix(lengthOfCommute)

longCommute = lengthOfCommute[,"45m"] + lengthOfCommute[,"60m"] +
              lengthOfCommute[,"90m"]
longCommutePerc = longCommute / lengthOfCommute[,"total"]

pdf(paste0(OUTDIR, "boxplotBasic.pdf"), 10, 5)
boxplot(longCommutePerc ~ geodf$county)
dev.off()

out = boxplot(longCommutePerc ~ geodf$county, plot=FALSE)
medians = out$stats[3,]

factorLevels = out$names[order(medians)]
countNameFactor = factor(geodf$county,levels=factorLevels)
pdf(paste0(OUTDIR, "boxplotOrder.pdf"), 10, 5)
par(mar=c(6,4,2,2))
boxplot(longCommutePerc ~ countNameFactor, las=2)
dev.off()


############### scatter

election = read.csv("../data/ch05/france_election_2012.csv",
                    as.is=TRUE)
election[1:5,]

# percRemain = (election$HOLLANDE_2 - election$HOLLANDE) /
#              (100 - election$HOLLANDE - election$SARKOZY )
# margin = abs(election$HOLLANDE_2 - election$SARKOZY_2)
# maxThirdParty = apply(election[,4:11],1,max)
# whichMaxThirdParty = apply(election[,4:11],1,which.max)

## Sequential pallete
thirdPartyVotes = apply(election[,4:11],1,sum)
cuts = quantile(thirdPartyVotes,probs=seq(0,1,length.out=11))
bins = cut(thirdPartyVotes, cuts, include.lowest=TRUE, labels=FALSE)
cols = heat_hcl(10)[11 - bins]

pdf(paste0(OUTDIR, "sequentialPalette.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")
dev.off()

## Diverging pallete
percRemain = (election$HOLLANDE_2 - election$HOLLANDE) /
             (100 - election$HOLLANDE - election$SARKOZY )
quantile(percRemain)

index = percRemain < 0.5
cutsLower = quantile(percRemain[index],probs=seq(0,1,length.out=11))
index = percRemain >= 0.5
cutsUpper = quantile(percRemain[index],probs=seq(0,1,length.out=11))
cuts = c(cutsLower,cutsUpper)
cuts

bins = cut(percRemain, cuts, include.lowest=TRUE, labels=FALSE)
cols = diverge_hcl(21,alpha=0.5)[bins]

pdf(paste0(OUTDIR, "divergingPalette.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")
dev.off()

## categorical pallete
whichMaxThirdParty = apply(election[,4:11],1,which.max)
cols = rainbow_hcl(3, alpha=0.5)[whichMaxThirdParty]

pdf(paste0(OUTDIR, "categoricalPalette.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")
dev.off()


############### legend

cols = rainbow_hcl(3, alpha=0.5)[whichMaxThirdParty]

pdf(paste0(OUTDIR, "categoricalLegend.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")

legend(45,50,legend=colnames(election)[4:6],
       col=rainbow_hcl(3, alpha=0.5),pch=19,cex=1,
       bg=grey(0.9))
dev.off()

thirdPartyVotes = apply(election[,4:11],1,sum)
cuts = quantile(thirdPartyVotes,probs=seq(0,1,length.out=11))
bins = cut(thirdPartyVotes, cuts, include.lowest=TRUE, labels=FALSE)
cols = heat_hcl(10)[11 - bins]

pdf(paste0(OUTDIR, "divergingLegend.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")

cuts = round(cuts[11:1])
legendLabels =paste(cuts[-1],"-",cuts[-length(cuts)], "%",sep="")

legend(45,50,legend=legendLabels, fill=heat_hcl(10), bg=grey(0.9))
dev.off()

############### randomness

# Simple sampling
cols = rainbow_hcl(3)[whichMaxThirdParty]

pdf(paste0(OUTDIR, "simpleTextPlot.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col="white",
      pch=19, cex=2, xlim=c(10,60), ylim=c(10,60),
      xlab="HOLLANDE %", ylab="SARKOZY %")
text(election$HOLLANDE, election$SARKOZY, election$department,
      col=cols)
dev.off()

sample(1:10,3)

index = which(whichMaxThirdParty %in% c(2,3))
index = c(index, sample(which(whichMaxThirdParty == 1), 15))

pdf(paste0(OUTDIR, "sampledTextPlot.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col="white",
      pch=19, cex=2, xlim=c(10,60), ylim=c(10,60),
      xlab="HOLLANDE %", ylab="SARKOZY %")
text(election$HOLLANDE[index], election$SARKOZY[index],
     election$department[index], col=cols[index], cex=0.6)
dev.off()

# More complex schema
location = round(election$SARKOZY/2) + round(election$HOLLANDE/10)*100

cols = rainbow_hcl(3)[whichMaxThirdParty]
colsAlpha = rainbow_hcl(3, alpha=0.2)[whichMaxThirdParty]

pdf(paste0(OUTDIR, "sampledTextPlotComplex.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col="white",
      pch=19, cex=2, xlim=c(10,60), ylim=c(10,60),
      xlab="HOLLANDE %", ylab="SARKOZY %")

set.seed(42)
points(election$HOLLANDE, election$SARKOZY,
       col=colsAlpha, cex=0.7, pch=19)
index = c()
for (i in 1:nrow(election)) {
  if (!(location[i] %in% index)) {
    text(election$HOLLANDE[i], election$SARKOZY[i]+1,
       election$department[i], col=cols[i], cex=0.7)
    index = c(index, location[i])
  }
}
dev.off()

############### additional tweaks

cols = rainbow_hcl(3, alpha=0.5)[whichMaxThirdParty]

pdf(paste0(OUTDIR, "ggplot2mimic.pdf"), 8, 8)
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")

rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],
     col = gray(0.9))
grid(lty="solid", col="white")
points(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
        cex=1.5)
dev.off()

pdf(paste0(OUTDIR, "legendOutside.pdf"), 10, 8)
par(mar=c(5.1, 4.1, 4.1, 10))
plot(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
     cex=1.5, xlab="HOLLANDE %", ylab="SARKOZY %")

rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],
     col = gray(0.9))
grid(lty="solid", col="white")
points(election$HOLLANDE, election$SARKOZY, col=cols, pch=19,
        cex=1.5)

legend(60,50,legend=colnames(election)[4:6],
       col=rainbow_hcl(3),pch=19,cex=1,
       xpd=TRUE,
       bty = "n")
dev.off()






