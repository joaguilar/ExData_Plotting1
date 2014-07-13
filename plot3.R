download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="exdata-data-household_power_consumption.zip")
datafile<-unzip("exdata-data-household_power_consumption.zip")
p3data<-read.table(
  datafile,
  skip=1,
  sep=";",
  na.strings = "?",
  nrows=100000,
  header=FALSE
  ,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
  col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
)


p3t<-paste(p3data[,1]," ",p3data[,2],sep="")
p3dt<-strptime(p3t,format="%d/%m/%Y %H:%M:%S")
p3dtdata<-cbind(p3dt,p3data)
p3subdtdata<-subset(p3dtdata,p3dtdata$p3dt>=strptime('01-02-2007',format="%d-%m-%Y") & p3dtdata$p3dt<strptime('03-02-2007',format="%d-%m-%Y"))

png(filename="plot3.png",width=480,height=480)
plot(p3subdtdata$Sub_metering_1 ~ p3subdtdata$p3dt,type="l",ylab="Energy sub metering",xlab="")
lines(p3subdtdata$Sub_metering_2 ~ p3subdtdata$p3dt,col="red")
lines(p3subdtdata$Sub_metering_3 ~ p3subdtdata$p3dt,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()
