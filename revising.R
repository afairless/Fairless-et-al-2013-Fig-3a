# Andrew Fairless, August 2011
# modified May 2015 for posting onto Github
# This script constructs the bar graph for Figure 3a of Fairless et al 2013
# Fairless et al 2013, doi: 10.1016/j.bbr.2012.08.051, PMID: 22982070, PMCID: PMC3554266

install.packages("gplots", dependencies = TRUE)   # install package if not already installed

library(gplots)               
source("barplot2af.txt")                          # contains barplot function

bargraphtable = read.table("bargraphtable.txt", header = TRUE, sep = "\t")      # table of parameters for bar graph
bars = t(bargraphtable[ ,5:7])                                                  # heights of the bars (group means)
lowerrbar = bargraphtable[ ,5] + bargraphtable[ ,6] + bargraphtable[ ,7] - bargraphtable$overallse  # upper error bar
upperrbar = bargraphtable[ ,5] + bargraphtable[ ,6] + bargraphtable[ ,7] + bargraphtable$overallse  # lower error bar
barcolors = t(bargraphtable[ ,9:11])
btwnbarspace = bargraphtable$btwnspace       # specifies amount of open space to the left of each bar
tkmks = seq(0, 40, by = 5)                   # tickmarks for left-hand y-axis 
tkmks2 = seq(0, 25, by = 5)                  # tickmarks for right-hand y-axis
xlabels = rep(c("female", "female", "   male", "   male"), 3)                        # x-axis labels
barmidpoints = c(2.1, 3.1, 4.9, 5.9, 8.5, 9.5, 11.3, 12.3, 14.9, 15.9, 17.7, 18.7)   # horizontal positions of bars
leg1 = c(barcolors[3, 1], barcolors[2, 1], barcolors[1, 1], 
         barcolors[3, 2], barcolors[2, 2], barcolors[1, 2])                               # legend colors
leg2 = c("C57BL/6J active (anogenital)", "C57BL/6J active (body)", "C57BL/6J active (nose)", 
         "BALB/cJ active (anogenital)", "BALB/cJ active (body)", "BALB/cJ active (nose)") # legend labels
lwd = 2                       # line width
sexverticaloffset = 1         # vertical position of "male" and "female" x-axis labels
ageverticaloffset = 2.5       # vertical position of age x-axis labels
xlabelcex = 1.3               # x-axis labels size


png(file = "active soc bar graph.png", width = 640, height = 512)	
par(mar = c(5.1, 4.1, 4.1, 4.1))
barplot2af(bars, plot.ci = TRUE, ci.l = lowerrbar, ci.u = upperrbar, ci.lwd = lwd, ylim = c(0, 45), 
           col = barcolors, space = btwnbarspace, ylab = "Portion (%) of all scored time points", 
           names.arg = NULL, cex.names = 1.5, las = 2, yaxt = "n", cex.lab = 1.5)
abline(h = 0, lwd = lwd)
axis(1, at = c(7.2, 13.6), las = 2, lwd = lwd, labels = c("",""), tck = -0.1)
axis(2, at = tkmks, las = 2, lwd = lwd, cex.axis = 1.6)
par(font = 2)
axis(4, at = tkmks2/0.61, las = 2, lwd = lwd, cex.axis = 1.6, labels = tkmks2)       
par(xpd = T)        
text(21.7, 22.5, "Number of time points", cex = 1.5, srt = 270)
par(xpd = F)
legend(12, 40, leg2, fill = leg1, cex = 1.0, bty = "o")
par(font = 1)
text(4.0, labels = "30 days", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = ageverticaloffset, font = 2)
text(10.4, labels = "41 days", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = ageverticaloffset, font = 2)
text(16.8, labels = "69 days", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = ageverticaloffset, font = 2)
text(c(2.6, 9.0, 15.4), labels = "female", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = sexverticaloffset, font = 2)
text(c(5.4, 11.8, 18.2), labels = "male", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = sexverticaloffset, font = 2)

lwd = 3
bar1 = 5
bar2 = 6
bar3 = 7
bar4 = 8
bar1mid = barmidpoints[bar1]
bar2mid = barmidpoints[bar2]
bar3mid = barmidpoints[bar3]
bar4mid = barmidpoints[bar4]
gap = 1
crossbarheight1 = max(upperrbar[bar1:bar4]) + (gap * 4)
crossbarheight2 = max(upperrbar[bar1:bar4]) + (gap * 6)
starx = mean(rbind(barmidpoints[bar1], barmidpoints[bar2], barmidpoints[bar3], barmidpoints[bar4]))
stary = max(crossbarheight1, crossbarheight2) + (abs(crossbarheight2 - crossbarheight1) * 1.5)

segments(barmidpoints[bar1], (upperrbar[bar1] + gap), barmidpoints[bar1], crossbarheight1, lwd = lwd)
segments(barmidpoints[bar2], (upperrbar[bar2] + gap), barmidpoints[bar2], crossbarheight2, lwd = lwd)
segments(barmidpoints[bar3], (upperrbar[bar3] + gap), barmidpoints[bar3], crossbarheight1, lwd = lwd)
segments(barmidpoints[bar4], (upperrbar[bar4] + gap), barmidpoints[bar4], crossbarheight2, lwd = lwd)
segments(barmidpoints[bar1], crossbarheight1, barmidpoints[bar3], crossbarheight1, lwd = lwd)
segments(barmidpoints[bar2], crossbarheight2, barmidpoints[bar4], crossbarheight2, lwd = lwd)
segments(mean(rbind(barmidpoints[bar1], barmidpoints[bar3])), crossbarheight1, starx, stary, lwd = lwd)
segments(mean(rbind(barmidpoints[bar2], barmidpoints[bar4])), crossbarheight2, starx, stary, lwd = lwd)
text(starx, (stary + (gap * 1.5)), labels = "*", cex = 6)

dev.off()	
