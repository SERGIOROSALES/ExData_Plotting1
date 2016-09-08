##Download the Data Set from the course web site:

If (!file.exists("./Exploratory Data Analysis/Data")){
dir.create("./Exploratory Data Analysis/Data")
}
LocationDS <- file.path(getwd(),"Exploratory Data Analysis/Data/household_power_consumption.zip")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, LocationDS)
unzip("./Exploratory Data Analysis/Data/household_power_consumption.zip",exdir="./Exploratory Data Analysis")

##read the data set
DataSet <- read.table("./Exploratory Data Analysis/household_power_consumption.txt",sep=";",dec=".",na.strings=c("?"),header=TRUE,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## Date in format dd/mm/yyyy and time in format hh:mm:ss into, and subset to red only the 2-day period in February, 2007.
DataSet <- transform(DataSet,DateTime= paste(Date, Time))
DataSet <- transform(DataSet,Date= strptime(DateTime, "%d/%m/%Y %H:%M:%S"))
DataSet <- subset(DataSet,Date > strptime("1/2/2007 0:0:0", "%d/%m/%Y %H:%M:%S") & Date < strptime("3/2/2007 0:1:0", "%d/%m/%Y %H:%M:%S"), select= c(Date,Global_active_power,Global_reactive_power,Voltage,Global_intensity,Sub_metering_1,Sub_metering_2,Sub_metering_3))

##Plot4
LocationPlot4 <- file.path(getwd(),"Exploratory Data Analysis/ExData_Plotting1/plot4.png")
png(file= LocationPlot4)
par(mfcol=c(2,2))

##Plot(1,1)
with(DataSet,plot(Date, Global_active_power, type= "n", ylab="Global Active Power (kilowatts)"))
lines(DataSet$Date,DataSet$Global_active_power)

##Plot(2,1)
with(DataSet,plot(Date, Sub_metering_1, type= "n", ylab="Energy sub metering", xlab="DateTime"))
lines(DataSet$Date,DataSet$Sub_metering_1,col="blue")
lines(DataSet$Date,DataSet$Sub_metering_2,col="green")
lines(DataSet$Date,DataSet$Sub_metering_3,col="red")
legend("topright",lwd=2,col=c("blue","green","red"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))

##Plot(1,2)
with(DataSet,plot(Date, Voltage, type= "n", ylab="Voltage", xlab="DateTime"))
lines(DataSet$Date,DataSet$Voltage)

##Plot(2,2)
with(DataSet,plot(Date, Global_reactive_power, type= "n", ylab="Global reactive power", xlab="DateTime"))
lines(DataSet$Date,DataSet$Global_reactive_power)
dev.off()


