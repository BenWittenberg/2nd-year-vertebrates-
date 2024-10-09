###########################################################################################
# Load packages and utility functions
###########################################################################################

# Clean your environment
rm(list=ls())

# Set drive & load required packages

#Home
#setwd("F:\\Phd\\OneDrive - University of Cape Town\\PhD\\R working\\PhD_detection_independence\\2km")

#Laptop
#setwd("C:\\Users\\User\\Pictures\\Biodiversity_survey_cleaned")
# ICWild hard drive
setwd("E:/Zoe Woodgate/UCT")

list.files()

pacman::p_load(camtrapR, tidyverse)

# Check which directories are in PATH (output not shown here)
Sys.getenv("PATH")

# Check if the system can find Exiftool (if output is empty "", system can't find Exiftool)
Sys.which("exiftool")

###########################################################################################
# Directories for the raw images
###########################################################################################

# load station file
camtraps <- read_delim("Station.csv", delim = ";")
camtraps

# create a temporary dummy directory 
#Already done? 
wd_createStationDir <- file.path("D:\\Zoe Woodgate\\UCT\\Sorted_images")

StationFolderCreate1 <- createStationFolders (inDir       = wd_createStationDir,
                                              stations    = as.character(camtraps$Station), 
                                              createinDir = TRUE)

# raw images location
wd_images_raw <- file.path("E:/Zoe Woodgate/UCT/Raw_images/2024/Final_round")   

# destination for renamed images to be copied to
wd_images_raw_renamed <- file.path("E:/Zoe Woodgate/UCT/Sorted_images/2024")       

# Run rename code
renaming.table2 <- imageRename(inDir               = wd_images_raw,
                               outDir              = wd_images_raw_renamed,       
                               hasCameraFolders    = FALSE,
                               copyImages          = TRUE
)
head(renaming.table2)

#NOTE TO SELF: check that the subfolders within each station (for each SD card) are also being read in. 

###########################################################################################
# Directories for the species
###########################################################################################

# species names for which we want to create subdirectories
species <- c("Domestic_cat", "Caracal","Cape_genet","Cape_grysbok","Grey_Squirrel",
             "Research_team","Blank","Bird","Water_mongoose","Cape_porcupine","Rodent",
             "Human","Vehicle","Research_team","Domestic_cat","Honey_badger","Cape_grey_mongoose")

# create species subdirectories
wd_createSpeciesFoldersTest <- file.path("E:/Zoe Woodgate/UCT/Sorted_images/2024")

SpeciesFolderCreate1 <- createSpeciesFolders (inDir               = wd_images_raw_renamed,
                                              species             = species,
                                              hasCameraFolders    = FALSE,
                                              removeFolders       = FALSE)

###########################################################################################
#Wait until end of survey 
# Tabulating species and individual records
###########################################################################################

rec.db.species0 <- recordTable(inDir  = wd_images_raw_renamed,
                               IDfrom = "directory",
                               minDeltaTime        = 60,
                               deltaTimeComparedTo = "lastIndependentRecord",
                               timeZone = "Africa/Johannesburg")
rec.db.species0 

write.csv(rec.db.species0,"UCT_biodiversity_2024.csv")

###########################################################################################
# Summary
###########################################################################################

Mapstest1 <- detectionMaps(CTtable     = camtraps,
                           recordTable  = rec.db.species0 ,
                           Xcol         = "utm_x",
                           Ycol         = "utm_y",
                           stationCol   = "Station",
                           speciesCol   = "Species",
                           printLabels  = TRUE,
                           richnessPlot = TRUE,    # by setting this argument TRUE
                           speciesPlots = FALSE,
                           addLegend    = TRUE
)





reportTest <- surveyReport (recordTable          = rec.db.species0 ,
                            CTtable              = camtraps,
                            speciesCol           = "Species",
                            stationCol           = "Station",
                            setupCol             = "Setup_date",
                            retrievalCol         = "Retrieval_date",
                            CTDateFormat         = "%Y-%m-%d", 
                            recordDateTimeCol    = "DateTimeOriginal",
                            recordDateTimeFormat = "%Y-%m-%d %H:%M:%S",
                            CTHasProblems        = TRUE)

reportTest[[4]]
reportTest[[3]]
reportTest[[5]]
poop <- as.data.frame(reportTest[[1]]  )
write.csv(poop,"poop.csv")
