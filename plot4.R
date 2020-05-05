library(dplyr)

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

FebData <- data %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02" ) %>% 
  mutate(DateTime = paste(Date, Time, sep=" "))

FebData$DateTime <- as.POSIXct(FebData$DateTime, format= "%Y-%m-%d %H:%M:%S")

windows()
dev.copy(png, file="plot4.png", height=480, width=480)

par(mfrow = c(2,2))
plot(FebData$Global_active_power ~ FebData$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(FebData$Voltage ~ FebData$DateTime, type = "l", ylab = "Voltage", xlab ="datetime")

plot(FebData$Sub_metering_1~FebData$DateTime, type = "l", xlab = "", ylab = "Energy sub metering" )
lines(FebData$Sub_metering_2~FebData$DateTime, col = "red")
lines(FebData$Sub_metering_3~FebData$DateTime, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = "solid")

plot(FebData$Global_reactive_power ~ FebData$DateTime, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

dev.off()
