library(data.table)
newFile <- fread("household_power_consumption.txt", na.strings = "?")
newFile[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
library(dplyr)
work.data <- filter(newFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))
GAP<-work.data[!is.na(work.data$Global_active_power), ]
x <- strptime(paste(GAP$Date, GAP$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
png(file ="plot2.png",width=480,height=480)
plot( x, GAP$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()