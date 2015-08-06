if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
power <- read.table(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

par(mfrow = c(2, 2))
plot(df$timestamp,df$Global_active_power,type="s",xlab="", ylab= "Global Active Power(kilowatts)", cex=0.2)

plot(df$timestamp, df$Voltage, xlab="datetime", ylab= "Voltage", type="s")

plot(df$timestamp, df$Sub_metering_1, ylab="Energy sub metering", xlab="", type="s")
lines(df$timestamp, df$Sub_metering_2, col = "red")
lines(df$timestamp, df$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", lwd=2.5, cex=0.28, col=c("black", "red", "blue"))

plot(df$timestamp, df$Global_reactive_power,xlab="datetime", ylab = "Global_reactive_power", type="s")

dev.copy(png,file="plot4.png", width=480, height=480)
dev.off()