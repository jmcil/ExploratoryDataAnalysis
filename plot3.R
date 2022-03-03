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

##Plot 3

with(powerconsumption,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(powerconsumption,lines(datetime,Sub_metering_2,col="red"))
with(powerconsumption,lines(datetime,Sub_metering_3,col="blue"))
plot3<-legend("topright",legend=c(paste0(rep("Sub_metering_",3),seq(1,3))),col=c("black","red","blue"),lty=rep(1,3))

dev.copy(png, file="plot3.png")
dev.off()