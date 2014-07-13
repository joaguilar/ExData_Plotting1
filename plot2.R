#Download the file and load it to a data frame
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="exdata-data-household_power_consumption.zip")
datafile<-unzip("exdata-data-household_power_consumption.zip")
p2data<-read.table(
  datafile,
  skip=1,
  sep=";",
  na.strings = "?",
  nrows=100000,
  header=FALSE
  ,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
  col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
)

#Join the date and time in just one column

p2t<-paste(p2data[,1]," ",p2data[,2],sep="")
p2dt<-strptime(p2t,format="%d/%m/%Y %H:%M:%S")
p2dtdata<-cbind(p2dt,p2data)
#Get the subset of the data for the analysis dates

p2subdtdata<-subset(p2dtdata,p2dtdata$p2dt>=strptime('01-02-2007',format="%d-%m-%Y") & p2dtdata$p2dt<strptime('03-02-2007',format="%d-%m-%Y"))

png(filename="plot2.png",width=480,height=480)
plot(p2subdtdata$Global_active_power ~ p2subdtdata$p2dt,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
