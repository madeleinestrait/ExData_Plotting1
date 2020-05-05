library(dplyr)

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

FebData <- data %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02" ) %>% 
  mutate(DateTime = paste(Date, Time, sep=" "))

FebData$DateTime <- as.POSIXct(FebData$DateTime, format= "%Y-%m-%d %H:%M:%S")

windows()
hist(FebData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
png(file="plot1.png", height=480, width=480)
