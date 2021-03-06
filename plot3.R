library(dplyr)

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

FebData <- data %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02" ) %>% 
  mutate(DateTime = paste(Date, Time, sep=" "))

FebData$DateTime <- as.POSIXct(FebData$DateTime, format= "%Y-%m-%d %H:%M:%S")

windows()
dev.copy(png, file="plot3.png", height=480, width=480)

plot(FebData$Sub_metering_1~FebData$DateTime, type = "l", xlab = "", ylab = "Energy sub metering" )
lines(FebData$Sub_metering_2~FebData$DateTime, col = "red")
lines(FebData$Sub_metering_3~FebData$DateTime, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = "solid")

dev.off()
