### checks distrodution of data
## goodluck
install.packages("fitdistrplus")
library(fitdistrplus)
BMtotal<-read.csv("GMGS_BM2019_2021_CSV.csv") #loads dataset
x<-(BMtotal$GMGSmeanmass)                     # defines x value
descdist(x, discrete = FALSE)                 #defines discrete or continous data
normal_dist <- fitdist(x, "norm")            
plot(normal_dist)