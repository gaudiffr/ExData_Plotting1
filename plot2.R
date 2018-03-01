## This script is used to download and process the dataset for "Electric Power 
## Consumption" data set for the Exploratory Analysis "Plot2" Course Project 
## assignment.

# Set up variables
path <- "/Coursera/Exploratoty Analysis"

fromDate = as.Date("2007-02-01")
thruDate = as.Date("2007-02-02")

## Check existance of dataset files and download if necessary
if (!file.exists(path)){
  dir.create(path)
}
setwd(path)

if (!file.exists("Dataset.zip")){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, destfile = "Dataset.zip", method = "curl")
  unzip("Dataset.zip", exdir = ".")
}

## Load the txt file and combine Date and Time into Timestamp
dataHPC <- read.csv("household_power_consumption.txt",
                    header = TRUE, 
                    sep = ";", 
                    colClasses = c(rep("character", 2), rep("numeric", 7)),
                    na.strings="?")
dataHPC$Timestamp <- strptime(paste(dataHPC$Date, dataHPC$Time),
                              format="%d/%m/%Y %H:%M:%S")

dataHPC$Date=NULL
dataHPC$Time=NULL

# Subset the large data set to include data withing dates (fromDate and thruDatre)
subHPC <- subset(dataHPC, as.Date(dataHPC$Timestamp) >= fromDate & as.Date(dataHPC$Timestamp) <= thruDate)

#plot the graph as png file
png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")

plot(subHPC$Timestamp, subHPC$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     col="black")

dev.off()
