#Read data for first day and second day
day1 <- read.table("household_power_consumption.txt", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")), nrows = 1440, header = F)
day2 <- read.table("household_power_consumption.txt", sep = ";", skip = grep("2/2/2007", readLines("household_power_consumption.txt")), nrows = 1440, header = F)


#Read only the headers
header <- read.table("household_power_consumption.txt", header = F, stringsAsFactors = F, nrows = 1, sep = ";")

#Combine the 2-day data
data <- rbind(day1, day2)

#add header
colnames(data) <- unlist(header)


#Combine the data/time columns and convert to dates
library(lubridate)
data$newdate <- dmy_hms(paste(data$Date, data$Time))


#Plot the needed data
png(filename = "plot2.png", height = 480, width = 480)
plot(data$newdate, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
