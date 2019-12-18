#Read data for first day and second day
day1 <- read.table("household_power_consumption.txt", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")), nrows = 1440, header = F)
day2 <- read.table("household_power_consumption.txt", sep = ";", skip = grep("2/2/2007", readLines("household_power_consumption.txt")), nrows = 1440, header = F)


#Read only the headers
header <- read.table("household_power_consumption.txt", header = F, stringsAsFactors = F, nrows = 1, sep = ";")

#Combine the 2-day data
data <- rbind(day1, day2)

#add header
colnames(data) <- unlist(header)


#Do the histogram
png(filename = "plot1.png", height = 480, width = 480)
hist(data$Global_active_power, col = "red", ylab = "Frequencey", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()