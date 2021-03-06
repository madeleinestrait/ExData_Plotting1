library(dplyr)

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

FebData <- data %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02" ) %>% 
  mutate(DateTime = paste(Date, Time, sep=" "))

FebData$DateTime <- as.POSIXct(FebData$DateTime, format= "%Y-%m-%d %H:%M:%S")

windows()
dev.copy(png, file="plot2.png", height=480, width=480)

plot(FebData$Global_active_power ~ FebData$DateTime,type="l", xlab = "", ylab = "Global Active Power (kilowatts)")


dev.off()
