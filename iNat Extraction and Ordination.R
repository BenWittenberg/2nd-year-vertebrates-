##Code for extracting georeferenced observations from iNaturalist

##Data will be used for univariate and multivariate comparisons of mammalian diversity in Cape Town protected areas 

##Start by setting your working directory 
#Mine is horrendously long so don't be like me 

setwd("C:/Users/bensc/Downloads/Ben UCT/GIT folder/2nd-year-vertebrates-")

#Now we need some observations from iNat. We will use the package rinat and the package vegan will help us with the diversity indices. 

##Ggplot2 will do the plotting for us 

#If you haven't already installed packages you'll want the install.packages() command 

#install.packages("rinat")
library(rinat)
#install.packages("sf") this will help with the georeferencing
library(sf)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("prettymapr")
library(prettymapr)
#install.packages("ggspatial")
library(ggspatial)

#To get the data we'll use the get_inat_obs function in rinat
?get_inat_obs

#First extract data for each protected area: 
#We need coordinates for each area
#FBNR = COORDS
#Helderberg = COORDS
#Tygerberg = COORDS
#Wolfgat = COORDS
#Steenbras = COORDS
#Table bay = COORDS
#Bracken = COORDS
#Blaauwberg = COORDS
#Witzands = COORDS
#Uitkamp = COORDS
#Kenilworth = COORDS

FBNR <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = c(-34, 18., -33.5, 18.5),
                     maxresults = 1000)

Held <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = c(-34, 18., -33.5, 18.5),
                     maxresults = 1000)

Tyg <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = c(-34, 18., -33.5, 18.5),
                     maxresults = 1000)

Wolf <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = c(-34, 18., -33.5, 18.5),
                     maxresults = 1000)



