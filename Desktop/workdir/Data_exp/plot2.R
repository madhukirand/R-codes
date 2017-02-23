data1 <- read.table("household_power_consumption.txt",sep=";",header = T,na.strings = "?",
                   stringsAsFactors = F)
data1$date_time <- paste(data1[,1],data1[,2])
data1$date_time <- strptime(data1$date_time, "%d/%m/%Y %H:%M:%S"," ")#%H:%M:%S
tail(data1)
data1$Date <- strptime(data1$Date, "%d/%m/%Y")
feb <- data1[(data1$Date<= as.POSIXct('2007-02-02')) & 
               (data1$Date>=as.POSIXct('2007-02-01')),]

def <- par()
par(mar=c(3,10,2,10))
png("plot2.png")
plot(feb$date_time,feb$Global_active_power,pch=20,type="l")
dev.off()
