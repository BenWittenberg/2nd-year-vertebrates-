###Badger script 

##I'm trying to plot sightings of honey badgers across the peninsula 

#Here's Jasper's GIS tutorial because I always use that as a crutch 

#https://www.ecologi.st/spatial-r/rdemo.html#adding-basemaps-to-plots
library(sf)
library(ggplot2)
library(dplyr)
library(ggspatial)
library(terra)

setwd("C:/Users/bensc/Downloads/Ben UCT/Honey badgers")

badger <- read.csv("Georeferenced sightings.csv")

badger <- st_as_sf(badger, coords = c("utm_x", "utm_y"), crs = 4326)

max_range <- st_read("Badger_max_range.shp")

crs(max_range)

min_range <- st_read("Badger_min_range.shp")

crs(min_range)
crs(badger)

#Make sure all the crs are the same 

min_range <- st_transform(min_range, crs(badger))

#Load some packages
#install.packages("mapview")
library(mapview)
#install.packages("leafpop")
library(leafpop)

?mapview


mapview(badger, 
        popup = 
          popupTable(badger,
                     zcol = c("Source", "Date")))

#Try this with leaflet 
library(leaflet)
library(htmltools)
leaflet(badger) %>% addTiles() %>%
  addMarkers(~utm_x, ~utm_y, popup = ~htmlEscape(c(Source,Date)))

library(ggspatial)

max_range

#Since I'm using OSM we need the proper attribution


plot <- ggplot()+
  annotation_map_tile(type = "osm",progress = "none",zoomin = -1)+
  geom_sf(data = badger, colour = "red", size = 4)+
  geom_sf(data = max_range, fill = "orange", alpha = 0.2)
  #geom_sf(data = min_range, fill = "blue", alpha = 0.4)
?annotation_map_tile

ggsave("badger_range.svg")

############################################################################################################################################################################################################

# Radial plot of activity for badgers
activityRadial(recordTable       = survey.data.2023,
               species           = "Honey_badger",
               allSpecies        = FALSE,
               speciesCol        = "Species",
               recordDateTimeCol = "DateTimeOriginal",
               plotR             = TRUE,
               writePNG          = FALSE,
               lwd               = 3,
               rp.type           = "p",     # plot type = polygon
               poly.col          = gray(0.5, alpha = 0.5)  # optional. remove for no fill 
)
