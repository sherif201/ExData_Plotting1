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
png(filename = "plot4.png", height = 480, width = 480)

#create 2x2 palette
par(mfrow = c(2,2))

#first graph
plot(data$newdate, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#second graph
plot(data$newdate, data$Voltage, ylab = "Voltage", type = "l", xlab = "datetime")

#third graph
with(data, plot(newdate, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
points(data$newdate, data$Sub_metering_2, type = "l", col = "red")
points(data$newdate, data$Sub_metering_3, type = "l", col = "blue")

#add legends to it
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= c(1,1,1), box.lty = 0, inset = .01)

#create 2x2 blank palette
par(mfrow = c(2,2))

#first graph
plot(data$newdate, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#second graph
plot(data$newdate, data$Voltage, ylab = "Voltage", type = "l", xlab = "datetime")
with(data, plot(newdate, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
points(data$newdate, data$Sub_metering_2, type = "l", col = "red")
points(data$newdate, data$Sub_metering_3, type = "l", col = "blue")

#add legends
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= c(1,1,1), box.lty = 0, inset = .01)

#fourth graph
plot(data$newdate, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()