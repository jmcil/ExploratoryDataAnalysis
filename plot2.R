## Loads the necessary packages

library(dplyr)
library(tidyr)
library(lubridate)

## Downloads, the data set and reads in the required txt files 

URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL,"./powerconsumption.zip", method = "libcurl", mode = "wb")

zipF<-"./powerconsumption.zip" 
outDir<-getwd()  
unzip(zipF,exdir=outDir)

powerconsumption<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",
                             colClasses = c("character","character",rep("numeric",7)))%>%
  filter(Date %in% c("1/2/2007","2/2/2007"))

powerconsumption$datetime<-paste(powerconsumption$Date, powerconsumption$Time,sep=", ")%>%
  strptime("%d/%m/%Y, %H:%M:%S")

## Plot 2

par(mfrow=c(1,1))
plot2<-with(powerconsumption,plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)"))

dev.copy(png, file="plot2.png")
dev.off()
