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

png(filename="plot2.png", width=480, height=480, units="px")
with(edf, plot(Date, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()



