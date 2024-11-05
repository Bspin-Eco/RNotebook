#Purpose: calculate root mean square error to asses the accuracy of
# the dandelion cover raster, using the ground survey

###join tables
library(sf)
library(dplyr)
library(tidyverse)

setwd("~/2022_RMBL_Summer/Spinner_Breckheimer_Project/data")

##Load data
Drone <- read.csv("~/2022_RMBL_Summer/Spinner_Breckheimer_Project/data/Dandelion_Drone_Count.csv")
Ground <- read.csv("~/2022_RMBL_Summer/Spinner_Breckheimer_Project/Dandelion_survey_CSVGROUND.csv")

##Previews datasets.
View(Drone)
View(Ground)

##Join tables.
Drone_Ground <- left_join(Drone,Ground, by=c("Name"="Name"))
View(Drone_Ground)

st_write

###graph drone v.s ground and find R^2
plot(Drone_Ground$Mean.DC, Drone_Ground$X_mean)
Rsqur_dande<-lm(Drone_Ground$Mean.DC~Drone_Ground$X_mean)
summary(Rsqur_dande)
install.packages("Metrics")
library(Metrics)
rmse(Drone_Ground$Mean.DC,Drone_Ground$X_mean)
