#Download the file and load it to a data frame
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="exdata-data-household_power_consumption.zip")
datafile<-unzip("exdata-data-household_power_consumption.zip")
p4data<-read.table(
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
p4t<-paste(p4data[,1]," ",p4data[,2],sep="")
p4dt<-strptime(p4t,format="%d/%m/%Y %H:%M:%S")
p4dtdata<-cbind(p4dt,p4data)
#Get the subset of the data for the analysis dates

p4subdtdata<-subset(p4dtdata,p4dtdata$p4dt>=strptime('01-02-2007',format="%d-%m-%Y") & p4dtdata$p4dt<strptime('03-02-2007',format="%d-%m-%Y"))

png(filename="plot4.png",width=480,height=480)
par(mfrow=c(2,2))

#plot 1:
plot(p4subdtdata$Global_active_power ~ p4subdtdata$p4dt,type="l",ylab="Global Active Power",xlab="")

#plot 2:
plot(p4subdtdata$Voltage ~ p4subdtdata$p4dt,type="l",ylab="Voltage",xlab="datetime")

#plot 3:
plot(p4subdtdata$Sub_metering_1 ~ p4subdtdata$p4dt,type="l",ylab="Energy sub metering",xlab="")
lines(p4subdtdata$Sub_metering_2 ~ p4subdtdata$p4dt,col="red")
lines(p4subdtdata$Sub_metering_3 ~ p4subdtdata$p4dt,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

#plot 4:
plot(p4subdtdata$Global_reactive_power ~ p4subdtdata$p4dt,type="l",ylab="Global_reactive_power",xlab="datetime")


dev.off()