library(data.table)
newFile <- fread("household_power_consumption.txt", na.strings = "?")
newFile[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
library(dplyr)
work.data <- filter(newFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))
GAP<-work.data[!is.na(work.data$Global_active_power), ]
GAP<-work.data[!is.na(work.data$Sub_metering_1), ]
GAP<-work.data[!is.na(GAP$Sub_metering_2), ]
GAP<-work.data[!is.na(GAP$Sub_metering_3), ]
x <- strptime(paste(GAP$Date, GAP$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
png(file ="plot4.png",width=480,height=480)
par(mfrow = c(2, 2))
plot( x, GAP$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot( x, GAP$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(x,GAP$Sub_metering_1, type = "l", ylim = c(0, max(GAP$Sub_metering_1, GAP$Sub_metering_2)), xlab="", ylab="Energy sub metering")  ## index plot with one variable
lines(x,GAP$Sub_metering_2, type = "l", col = "red")
lines(x,GAP$Sub_metering_3, type = "l", col = "blue")## add another variable
legend("topright", lwd = 2, lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot( x, GAP$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()