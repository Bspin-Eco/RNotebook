###Bodie Spinner
## 03/08/23
# Spaital Lab
library(tidyverse)
library(sf)
library(terra)
library(tmap)
library(tigris)

## tigris accesses a database and downloads shapefiles
# download county shapefile for the state of Colorado
counties <- counties(state = "CO")
roads <- roads(state = "CO", county = "Larimer")

##tmap
#Once you set the mode with tmap_mode(), every plot call to tmap after that produces a plot in that mode.
#When you render this document to Word it will throw errors if you are trying to create interactive maps. Before rendering change “view” to “plot” in this code chunk.
tmap_mode("view")

#Using qtm
qtm(counties)+
  qtm(roads)

#Using tm_shape
tm_shape(counties)+
  tm_polygons()+
  tm_shape(roads)+
  tm_lines()

class(counties)

#filters to 1 roads
poudre_hwy <- roads %>% 
  filter(FULLNAME == "Poudre Canyon Hwy")

#map road
qtm(poudre_hwy)

#stores points
poudre_points <- data.frame(name = c("Mishawaka", "Rustic", "Blue Lake Trailhead"),
                            long = c(-105.35634, -105.58159, -105.85563),
                            lat = c(40.68752, 40.69687, 40.57960))

#convert to sf (usable to map) and set CRS ro WGS84
poudre_points_sf <- st_as_sf(poudre_points, coords = c("long", "lat"), crs = 4326)

qtm(poudre_hwy)+
  qtm(poudre_points_sf)

# see the CRS in the header metadata:
counties

#return just the CRS (more detailed)
st_crs(counties)

#reproject
poudre_points_prj <- st_transform(poudre_points_sf, crs = st_crs(counties))

#Now check that they match
st_crs(poudre_points_prj) == st_crs(counties)

#download raster from desktop
elevation <- rast("data/elevation.tif")

tm_shape(elevation)+
  tm_raster(style = "cont", title = "Elevation (m)")

#elevation metadata
elevation

#view CRS
crs(elevation)

#clip raster
elevation_crop <- crop(elevation, ext(poudre_hwy))

#map clipped raster
qtm(elevation_crop)+
  qtm(poudre_hwy)+
  qtm(poudre_points_prj)

#Write_sf saves shapefiles
write_sf(poudre_hwy, "data/poudre_hwy.shp")

write_sf(poudre_points_prj, "data/poudre_points.shp")

#writeRaster saves rasters
writeRaster(elevation_crop, "data/elevation_crop.tif")

#reading shapefiles
poudre_hwy <- read_sf("data/poudre_hwy.shp")
