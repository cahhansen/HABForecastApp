library(maptools)
library(magrittr)
load('data/Sites.RData')
load('data/chldata.RData')
load('data/LakeStationInfo/GSLBorder.RData')

testvals <- subset(chldata, Date=="1984-05-08" & Lake=="GSL")
testsites <- subset(sites, Lake=="GSL")
testvals$Latitude <-NA
testvals$Longitude <- NA

testvals$Latitude <- sites$Latitude[match(testvals$StationID,sites$StationID)]
testvals$Longitude <- sites$Longitude[match(testvals$StationID,sites$StationID)]

require(classInt)
require(RColorBrewer)
nclr = 9
plotvar <- testvals$Value
class <- classIntervals(plotvar, nclr,
                        style = "quantile", dataPrecision = 2)
plotclr <- brewer.pal(nclr, "Greens")
colcode <- findColours(class, plotclr, digits = 3)
plot(testsites, bg = colcode, pch=21, axes = T)
plot(gsl.border, add=T)
title(main = "GSL Chlorophyll Data")
legend("topleft", legend = names(attr(colcode, "table")),
       fill = attr(colcode, "palette"), cex = 0.8)

library(gstat,sp)
coordinates(testvals) <- c("Longitude","Latitude")
chl.var <- variogram(Value ~ 1,testvals)
plot(chl.var, plot.numbers=TRUE, pch='+')
chl.vgm <- vgm(psill=200, "Gau", range=0.13, nugget=0)
plot(chl.var,chl.vgm)

chl.vgm2 <- fit.variogram(chl.var, chl.vgm)
plot(chl.var, chl.vgm2)

#Make a grid for interpolation
require(splancs)
library(ggplot2)
grd <- makegrid(gsl.border, n = 10000)
colnames(grd) <- c('x','y')
outline <- gsl.border@polygons[[1]]@Polygons[[1]]@coords
new_grd <- grd[inout(grd,outline), ]
coordinates(new_grd) <- c("x","y")

chl.pred.ok <- krige(Value ~ 1, testvals, new_grd, chl.vgm2)
chl.pred.ok %>% as.data.frame %>%
  ggplot(aes(x=x, y=y)) + geom_tile(aes(fill=var1.pred)) + coord_equal() +
  scale_fill_gradient(low = "yellow", high="red",name="Chl (ug/L)") +
  scale_x_continuous() + scale_y_continuous() +
  theme_bw()+ggtitle("Example Interpolation of Chlorophyll Values")
