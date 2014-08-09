## Read Feb data... skip 66636 rows and read next 2880 rows (2*24*60)
## for the first two days of Feb 2007

edf <- read.table("./household_power_consumption.txt", header=TRUE, skip=66636, nrows=2880, na.strings="?", stringsAsFactors=FALSE, sep=";")

## Read first few rows to get actual header data, extract column names in header,
## and make them column names of the first two days Feb subset 

hdf <- read.table("./household_power_consumption.txt", header=TRUE, nrows=5, na.strings="?", stringsAsFactors=FALSE, sep=";")
colnames(edf) <- colnames(hdf)

## Replace Date column with date/time pasted together and converted to pOSIXlt
edf$Date <- strptime(paste(edf$Date,edf$Time), "%d/%m/%Y %H:%M:%S")

## Set the plot device to png file, and specify plot window size
## plot day-of-week vs Global Active Power, remove xlabel, adjust ylabel, and 
## close device

png(filename="plot4.png", width=480, height=480, units="px")
par(mfcol = c(2,2))

with(edf, plot(Date, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

with(edf, plot(Date, Sub_metering_1, type="l", col = "black", xlab = "", ylab = "Energy Metering"))
with(edf, points(Date, Sub_metering_2, type="l", col="red"))
with(edf, points(Date, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(edf, plot(Date, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

with(edf, plot(Date, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()

