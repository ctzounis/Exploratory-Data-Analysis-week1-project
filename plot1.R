library(data.table)
newFile <- fread("household_power_consumption.txt", na.strings = "?")
newFile[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
library(dplyr)
work.data <- filter(newFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))
GAP<-work.data[!is.na(work.data$Global_active_power), ]
png(file ="plot1.png",width=480,height=480)
hist(GAP$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()