download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="exdata-data-household_power_consumption.zip")
datafile<-unzip("exdata-data-household_power_consumption.zip")
p1data<-read.table(
  datafile,
  skip=1,
  sep=";",
  na.strings = "?",
  nrows=100000,
  header=FALSE
  ,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
  col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
)


p1t<-paste(p1data[,1]," ",p1data[,2],sep="")
p1dt<-strptime(p1t,format="%d/%m/%Y %H:%M:%S")
p1dtdata<-cbind(p1dt,p1data)
p1subdtdata<-subset(p1dtdata,p1dtdata$p1dt>=strptime('01-02-2007',format="%d-%m-%Y") & p1dtdata$p1dt<strptime('03-02-2007',format="%d-%m-%Y"))

#Plot 1
png(filename="plot1.png",width=480,height=480,units='px')
hist(p1subdtdata$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()