data1 <- read.table("household_power_consumption.txt",sep=";",header = T,na.strings = "?",
          stringsAsFactors = F)
data1$Date <- strptime(data1$Date, "%d/%m/%Y")
data1$date_time <- paste(data1[,1],data1[,2])
data1$date_time <- strptime(data1$date_time, "%d/%m/%Y %H:%M:%S"," ")#%H:%M:%S
feb <- data1[(data1$Date<= as.POSIXct('2007-02-02')) & 
                    (data1$Date>=as.POSIXct('2007-02-01')),]
View(feb)
png("plot1.png")
with(feb,hist(Global_active_power,col="red",xlab ="Global Active Power(Kilowatts)",
     main ="Global Active Power"))

dev.off()
