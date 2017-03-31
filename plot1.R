library(dplyr)
library(lubridate)

#Reads into the semi colon separated data with first line as column names
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Changes the class of Date and Time column to the required class
data <- mutate(data, Date = dmy(Date), Time = hms(Time))

#Filters the data for the required date
data <- filter(data, Date == "2007-2-1" | Date == "2007-2-2")

#Creates the plot and save it the .png file of required dimension
png(file = "plot1.png", width = 400, height = 400)
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()