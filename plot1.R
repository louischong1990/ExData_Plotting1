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

#Plot 1
hist(hpc$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png, file = "plot1.png")
dev.off()
