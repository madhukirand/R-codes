data1 <- read.table("household_power_consumption.txt",sep=";",header = T,na.strings = "?",
                    stringsAsFactors = F)
data1$date_time <- paste(data1[,1],data1[,2])
data1$date_time <- strptime(data1$date_time, "%d/%m/%Y %H:%M:%S"," ")#%H:%M:%S
tail(data1)
data1$Date <- strptime(data1$Date, "%d/%m/%Y")
feb <- data1[(data1$Date<= as.POSIXct('2007-02-02')) & 
               (data1$Date>=as.POSIXct('2007-02-01')),]
png("plot4.png")
par(mfrow=c(2,2))
plot(feb$date_time,feb$Global_active_power,type="l")
plot(feb$date_time,feb$Voltage,type = "l")
plot(feb$date_time,feb$Sub_metering_1,pch=20,type="l")
points(feb$date_time,feb$Sub_metering_2,type = "l",col="red")
points(feb$date_time,feb$Sub_metering_3,type = "l",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col = c("black","red","blue"))
plot(feb$date_time,feb$Global_reactive_power,type="l")
dev.off()
