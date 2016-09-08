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

##Plot1
LocationPlot1 <- file.path(getwd(),"Exploratory Data Analysis/ExData_Plotting1/plot1.png")
png(file= LocationPlot1)
with(DataSet,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()