data<-read.table("household_power_consumption.txt",sep=";",header=TRUE) ##reading the downloaded data

data1<-subset(data,Date==c("1/2/2007") | Date==c("2/2/2007"))           ##subsetting the data for dates 1/2/2007 & 2/2/2007

##combining Date&Time variable and changing class using strptime; result is saved as dataframe "dt_tm"
dt_tm<-data.frame(datetime=strptime(paste(data1$Date,data1$Time,sep=" "),"%d/%m/%Y %H:%M:%S"))

##adding dt_tm in the subsetted date as a new column with name "datetime"; resulted new dateframe is "df"
df<-cbind(data1,dt_tm)          ## dim(df) is [2880 * 10]

##Converting class of column 3 thru 9 from factor to numeric
for(i in 3:9){
        df[,i]<-as.numeric(as.character(df[,i]))
}

##Plotting graph 1 and saving as a PNG file
with(df,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(df,lines(datetime,Sub_metering_2,type="l",col="red"))
with(df,lines(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
dev.copy(png,file="plot3.png")
dev.off()
