####linear regression
##author:Bodie Spinner
#8/3/2022
library(sf)
library(dplyr)
library(tidyverse)
setwd("~/2022_RMBL_Summer/Spinner_Breckheimer_Project/data/Final Products")
##2021
GMGS_BM2021<-read.csv("GMGS2021_meanBM.csv")
Therm852021<-read.csv("GMGS85_aThermV1.2.csv")
Perch852021<-read.csv("GMGS85_aPerchesV1.1.csv")
VegCover852021<-read.csv("GMGS85_aVegCoverV1.1.csv")
Dande852021<-read.csv("GMGS85_aDandeV1.1.csv")
Therm552021<-read.csv("GMGS55_aThermV1.1.csv")
Perch552021<-read.csv("GMGS55_aPerchesV1.1.csv")
VegCover552021<-read.csv("GMGS55_aPVegCoverV1.1.csv")
Dande552021<-read.csv("GMGS55_aDandeV1.1.csv")

##2020
GMGS_BM2020<-read.csv("GMGS2020_BMmean.csv")
Therm852020<-read.csv("GMGS85_Therm2020.csv")
Perch852020<-read.csv("GMGS85_Perches2020.csv")
VegCover852020<-read.csv("GMGS85_VegCover2020.csv")
Dande852020<-read.csv("GMGS85_Dande2020.csv")
Therm552020<-read.csv("GMGS55_Therm2020.csv")
Perch552020<-read.csv("GMGS55_Perches2020.csv")
VegCover552020<-read.csv("GMGS55_VegCover2020.csv")
Dande552020<-read.csv("GMGS55_Dande2020.csv")

#2019
GMGS_BM2019<-read.csv("GMGS2019_meanBM.csv")
Therm852019<-read.csv("GMGS85_Therm2019.csv")
Perch852019<-read.csv("GMGS85_Perches2019.csv")
VegCover852019<-read.csv("GMGS85_VegCover2019.csv")
Dande852019<-read.csv("GMGS85_Dande2019.csv")
Therm552019<-read.csv("GMGS55_Therm2019.csv")
Perch552019<-read.csv("GMGS55_Perches2019.csv")
VegCover552019<-read.csv("GMGS55_VegCover2019.csv")
Dande552019<-read.csv("GMGS55_Dande2019.csv")
#all years
HabitatQ<-read.csv("GMGS_2022_2018_HabitatQuaility.csv")
Habitat40<-read.csv("GMGS_2022_2018_HabitatQuaility_over40.csv")
view(HabitatQ)
#Multi Lin Reg
Habitat85<-lm(HabitatQ$MeanBMPerDay~HabitatQ$area85+HabitatQ$Dande85_mean+HabitatQ$VegCover85_mean+HabitatQ$Therm85_mean+HabitatQ$Perches85_count, data=HabitatQ)
plot(Habitat85)

Habitat4055<-lm(Habitat40$GMGSmeanmass~Habitat40$area55+Habitat40$Dande55_mean+Habitat40$VegCover55_mean+Habitat40$Therm55_mean+Habitat40$Perches55_count, data=HabitatQ)
Summary(Habitat4055)

plot(Habitat55)

Habitat55<-lm(HabitatQ$MeanBMPerDay~HabitatQ$area55+HabitatQ$Dande55_mean+HabitatQ$VegCover55_mean+HabitatQ$Therm55_mean+HabitatQ$Perches55_count, data=HabitatQ)
plot(Habitat55)

Dande85<-lm(HabitatQ$GMGSmeanmass~HabitatQ$Dande85_mean, data = HabitatQ)
summary(Dande85)

Dande55<-lm(HabitatQ$GMGSmeanmass~HabitatQ$Dande55_mean)
Therm85 <-lm(HabitatQ$MeanBMPerDay~ HabitatQ$Therm85_mean)
Area85<- lm(HabitatQ$GMGSmeanmass~ HabitatQ$area85)

summary(Area85)
summary(Therm85)
summary(Dande55)

summary(Habitat85)

summary(Habitat55)
view(sum55)

plot(HabitatQ$EARTAGS~HabitatQ$Dande55_mean)
