##Code for generating home range polygons from squirrel activity data.
##Author: Ian Breckheimer and Bodie Spiner
##Updated: 21 July 2022

##Sets up workspace
setwd("G://My Drive//BreckheimerLab2022//Student//BodieSpinner")

library(sf)
library(dplyr)

##Load data
coords <- read.csv("./Data/GMGS_gridID.csv")
activity_log <- read.csv("./Data/activity_log_Adult_females_2021.csv")
activity_log <- activity_log[activity_log$DATE != " ",]

##Previews datasets.
View(coords)
View(activity_log)

##Join tables.
activity_coords <- left_join(activity_log,coords, by=c("GRID"="gridID"))
View(activity_coords)

##Create MCPs
animals <- unique(activity_coords$ANIMAL)

for(i in 1:length(animals)){
  print(paste("Creating MCPs for animal ",i, "of",length(animals)))
  activity_animal <- filter(activity_coords,ANIMAL==animals[i] & !is.na(x))
  animal_points <- st_as_sf(activity_animal,coords=c("x","y"),crs=st_crs("EPSG:26913"))
  animal_buff <- st_union(st_buffer(animal_points,dist=15))
  animal_polygon <- st_convex_hull(st_union(animal_points))
  plot(animal_polygon)
  out_filename <- paste("./Data/MCPs/GMGS_2021",gsub("/","_",animal_points$ANIMAL[1]),".shp",sep="")
  out_filename_pts <- paste("./Data/MCPs/GMGS_2021",gsub("/","_",animal_points$ANIMAL[1]),"_points.shp",sep="")
  out_filename_buff <- paste("./Data/MCPs/GMGS_2021",gsub("/","_",animal_points$ANIMAL[1]),"_buff.shp",sep="")
  st_write(animal_buff,dsn=out_filename)
  st_write(animal_points,dsn=out_filename_pts)
  st_write(animal_buff,dsn=out_filename_buff)
}

##Write data to disk.