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

#Creates the plot and save it the .png file of required dimension
png(file = "plot2.png", width = 400, height = 400)
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
plot(datetime, data$Global_active_power, type = "n", ylab = "Global active power (kilowatts)")
lines(datetime, data$Global_active_power)
dev.off()
