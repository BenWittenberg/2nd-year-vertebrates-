##Code for extracting georeferenced observations from iNaturalist

##Data will be used for univariate and multivariate comparisons of mammalian diversity in Cape Town protected areas 

##Start by setting your working directory 
#Mine is horrendously long so don't be like me 

setwd("C:/Users/bensc/Downloads/Ben UCT/GIT folder/2nd-year-vertebrates-")

#There are plenty of useful links out there. Here's one that I found 
#https://www.r-bloggers.com/2021/12/mapping-inaturalist-data-in-r/

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
#install.packages("tidyverse") this will help with our data sorting 
library(tidyverse)
#install.packages("dplyr")
library(dplyr)
#install.packages("vegan") this will help with getting diversity values
library(vegan)

#To get the data we'll use the get_inat_obs function in rinat
?get_inat_obs



##Filter for accuracy and quality
data <- data %>% filter(positional_accuracy<50 & 
                          latitude<0 &
                          !is.na(latitude) &
                          captive_cultivated == "false" &
                          quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)

#Make it a spatial object 


data <- st_as_sf(data, coords = c("longitude", "latitude"), crs = 4326)

#Now we need to import all our shapefiles
FBNR <- st_read("FBNR.shp")
Blaauw <- st_read("Blaauwberg.shp")
Brack <- st_read("Bracken.shp")
Held <- st_read("Helderberg.shp")
Wit <- st_read("Witzands_aquifer.shp")
Wolf <- st_read("Wolfgat.shp")
Tyg <- st_read("Tygerberg.shp")
Uit <- st_read("Uitkamp.shp")
Zand <- st_read("Zandvlei.shp")
Ken <- st_read("Kenilworth.shp")
TB <- st_read("Table_bay.shp")
SB <- st_read("Steenbras.shp")

#Check what class our shapefiles are 
class(SB)
#Returns "sf" (special feature) which means it is a spatial object as well as "data.frame" which is helpful if there is any additional info in the file (e.g. info on environmental conditions)

#Now we need to filter our data to get observations from each reserve 
FBNR_data <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = FBNR,
                     maxresults = 3000)
FBNR_data <- FBNR_data %>% filter(positional_accuracy<50 & 
                          latitude<0 &
                          !is.na(latitude) &
                          captive_cultivated == "false" &
                          quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
FBNR_data$region <- "FBNR"



Held_data <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = Held,
                     maxresults = 1000)
Held_data <- Held_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Held_data$region <- "Helderberg"

Tyg_data <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = Tyg,
                     maxresults = 1000)
Tyg_data <- Tyg_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Tyg_data$region <- "Tygerberg"


Wolf_data <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = Wolf,
                     maxresults = 1000)
Wolf_data <- Wolf_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Wolf_data$region <- "Wolfgat"

Zand_data <- get_inat_obs(taxon_name = "Mammalia",
                     bounds = Zand,
                     maxresults = 1000)
Zand_data <- Zand_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Zand_data$region <- "Zandvlei"

Ken_data <- get_inat_obs(taxon_name = "Mammalia",
                          bounds = Ken,
                          maxresults = 1000)
Ken_data <- Ken_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Ken_data$region <- "Kenilworth"

SB_data <- get_inat_obs(taxon_name = "Mammalia",
                        bounds = SB,
                        maxresults = 1000)
SB_data <- SB_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
SB_data$region <- "Steenbras"


TB_data <- get_inat_obs(taxon_name = "Mammalia",
                        bounds = TB,
                        maxresults = 1000)
TB_data <- TB_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
TB_data$region <- "Table_bay"

Uit_data <-get_inat_obs(taxon_name = "Mammalia",
                        bounds = Uit,
                        maxresults = 1000)
Uit_data <- Uit_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Uit_data$region <- "Uitkamp"

Blaauw_data <- get_inat_obs(taxon_name = "Mammalia",
                            bounds = Blaauw,
                            maxresults = 1000)
Blaauw_data <- Blaauw_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Blaauw_data$region <- "Blaauwberg"

Brack_data <- get_inat_obs(taxon_name = "Mammalia",
                           bounds = Brack,
                           maxresults = 1000)
Brack_data <- Brack_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Brack_data$region <- "Bracken"
#I might need to draw a single polygon around bracken, that might help 

Wit_data <- get_inat_obs(taxon_name = "Mammalia",
                         bounds = Wit,
                         maxresults = 1000)
Wit_data <- Wit_data %>% filter(positional_accuracy<50 & 
                                    latitude<0 &
                                    !is.na(latitude) &
                                    captive_cultivated == "false" &
                                    quality_grade == "research")%>%
  separate(col = "datetime", c("Date",NA), sep = " ", remove = TRUE)
Wit_data$region <- "Witzands"

#Now we need to quickly bind all our observations together 

#If we want to preserve the columns we usually use the cbind function. But this requires there to be the same number of rows in each dataframe. So instead we will be using the full_join function

df <-  Blaauw_data %>%
  full_join(Brack_data)%>%
  full_join(FBNR_data)%>%
  full_join(Held_data)%>%
  full_join(Ken_data)%>%
  full_join(SB_data)%>%
  full_join(TB_data)%>%
  full_join(Tyg_data)%>%
  full_join(Uit_data)%>%
  full_join(Wit_data)%>%
  full_join(Wolf_data)%>%
  full_join(Zand_data)%>%
  full_join(Wit_data)



#Check out how many species we got: 
table(df[df$region == "Blaauwberg",8])#column 8 is the common name column, we could use the scientific name but let's keep things simple 

#Using this we can get the number of individuals of each species in each reserve

#Okay! We're all sorted for our analysis 

#To shorten things I've made a data frame for us: 

matrix <- read.csv("Mammal_matrix.csv")

#remove the marine mammals - this isn't looking at those 
#remove the bats - we also aren't looking at those 

#What we're interested in is the terrestrial fauna that could in theiry be picked up by a camera trap 
colnames(matrix)
matrix <- matrix[,-c(9,29,38,40,45,47,52)]
summary(matrix)


#What was the diversity for each reserve? 

#We will use "vegan" for this 
#First get the alpha diversity (species counts)
ncol(matrix)

#We have 52 columns so a total of 51 species were found, but we need totals for each protected area 

matrix$Alpha <- specnumber(matrix[2:52])

#Our most diverse reserve (Blaauwberg) had 23 species. That stacks up pretty well against camera trap images 

#But species counts is only one measure. What about the eveness? We'll use Shannon-Wiener diversity which balances abundance and diversity 

matrix$Shannon <- diversity(matrix[2:52])

#Blaauwberg is once again the winner with 2.8

##########################################################################################################################

#Ordination 

#Univariate diversity indices tell us nothing about composition between sites. You can have identical diversity scores but share none of the same species. So we'll do what's called an ordination 


#First get the species matrix on it's own 
Spp <- matrix[,2:52]

#Note that this analysis will not like any regionjs where no species were detected, but that shouldn't be a problem as none of our reserves had an alpha diversity = 0 

SppMDS <- metaMDS(Spp, distance = "bray", k=2)
plot(SppMDS, type = "t")

#Now we extract the values from this and assign them to the original dataset 
scores <- as.data.frame(scores(SppMDS)$sites)

scores$region <- matrix$region

#Now we can make a pretty plot 

ggplot(scores, aes(x = NMDS1, y = NMDS2)) + 
  geom_point(size = 4, aes(colour = region))+ 
  theme(axis.text.y = element_text(colour = "black", size = 12, face = "bold"), 
        axis.text.x = element_text(colour = "black", face = "bold", size = 12), 
        legend.text = element_text(size = 12, face ="bold", colour ="black"), 
        legend.position = "right", axis.title.y = element_text(face = "bold", size = 14), 
        axis.title.x = element_text(face = "bold", size = 14, colour = "black"), 
        legend.title = element_text(size = 14, colour = "black", face = "bold"), 
        panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA,       size = 1.2),
        legend.key=element_blank()) + 
  labs(x = "NMDS1", colour = "Protected area", y = "NMDS2", shape = "Type")  + 
  scale_colour_manual(values = c("orange", "blue","green","red","lightblue","lightgrey","pink","darkblue","lightgreen","darkgreen","yellow","magenta"))

#Look at R charts if you want to change the colour pallete
#You can also adjust the opacity to get pastel shades using the alpha = function 

#But now we need to check that there actually is a difference 

#Usually we'd use an anosim for this, but that requires there to be replicates within groups, so we will save that fopr when we get the camera trap data 


































