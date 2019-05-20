#Download Data
library(data.table)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('./Data Science/Household Power Consumption.zip')){
  download.file(fileurl,'./Data Science/Household Power Consumption.zip', mode = 'wb')
  unzip('./Data Science/Household Power Consumption.zip', exdir = getwd())
}

#Read Data
hpc <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc <- subset(hpc,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
hpc <- hpc[complete.cases(hpc),]
datetime <- paste(hpc$Date, hpc$Time) #combine date and time
datetime <- setNames(datetime, "DateTime")
hpc <- hpc[ ,!(names(hpc) %in% c("Date","Time"))] #delete data and time columns
hpc <- cbind(datetime, hpc) #add datetime column
hpc$datetime <- as.POSIXct(datetime)

#Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(hpc, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="datetime")
})
