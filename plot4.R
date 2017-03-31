library(dplyr)
library(lubridate)

#Reads into the semi colon separated data with first line as column names
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Changes the class of Date and Time column to the required class
data <- mutate(data, Date = dmy(Date))

#Filters the data for the required date
data <- filter(data, Date == "2007-2-1" | Date == "2007-2-2")

#Creating a datetime object by combining date and time
datetime <- as.POSIXct(paste(data$Date, data$Time))

#Converting the required variables into numeric 
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#Creates a file device and a blank canvas
png(file = "plot4.png", width = 400, height = 400)
par(mfcol = c(2, 2))

##Plot number 1
{
        plot(datetime, data$Global_active_power, type = "n", ylab = "Global active power (kilowatts)")
        lines(datetime, data$Global_active_power)
}

##Plot number 2
{
        plot(datetime, data$Sub_metering_1, type = "n", ylab = "Energy Sub Metering")
        
        #Plots all the three required lines
        lines(datetime, data$Sub_metering_1, col = "black")
        lines(datetime, data$Sub_metering_2, col = "red")
        lines(datetime, data$Sub_metering_3, col = "blue")
        
        #Draws the legend
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), lty = c(1, 1, 1))
}

##Plot number 3
{
        plot(datetime, data$Voltage, type = "n", ylab = "Voltage")
        lines(datetime, data$Voltage)
}

##Plot number 4
{
        plot(datetime, data$Global_reactive_power, type = "n", ylab = "Global reactive power (kilowatts)")
        lines(datetime, data$Global_reactive_power)
}

dev.off()
