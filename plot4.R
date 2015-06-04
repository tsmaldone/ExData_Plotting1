#
# Exploratory Data Analysis - Project #1
#
# plot4.R
#
# Using the household_power_consumption data from the "Individual household
# electric power consumption Data Set", this routine will create a "quad-plot".
# four plots to the page. Two of the plots are those constructed in plot2.R and
# plot3.R. The third plot is that of voltage versus day of the week. The fourth
# plot is that of Global_reactive_power (household global minute-averaged reactive
# power, in kilowatts) versus day of the week. All plots will be for the dates
# 01 Feb 2007 and 02 Feb 2007 (a Thursday and Friday)
#
# From an exploratory data analysis perspective the plots of the Global Active
# versus day of the week and Energy sub metering versus day of the week are as
# that discussed in Plot2.R and plot3.R, respectively. The voltage versus day
# of the week plot shows the fluctuation of energy use during the course of the
# day with lowest being during mid day and night (people out, asleep) and highest
# during the evening and early morning (people home, getting ready for work, 
# etc.). The Global_reactive_power versus day of the week plot shows seemingly
# fluctuations, though not being an expert on "reactive" power, the interpretation
# escapes me.
#
# Tony Smaldone
# June 2, 2015
#
# read in the data, using the ";" as the field separator and removing and missing
# values from the data set (coded as a "?")
#
allData <- read.csv("household_power_consumption.txt",sep=";",na.strings="?")
#
# convert the Date data to be that of class Date, recognizing that the format
# of the input date data is dd/mm/yy, replace into the original data frame
#
allData$Date <- as.Date(allData$Date, format = "%d/%m/%Y")
#
# Subset the data to include only the data for the above specified dates
# To accomplish this, will use, what I call, a recursive subset, but since the
# Date data was converted to class Date, the means by which the subsetting is
# different than that for plot1.R (the histogram)
#
daysOfInterest<-subset(allData,subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#
# create a new frame converting the date and time to posix to allow for days of
# the week conversion
#
timesOfDay <- paste(as.Date(daysOfInterest$Date), daysOfInterest$Time)
posixTimesOfDay <- as.POSIXct(timesOfDay)
#
# using the par function, specify that the plots will be on two rows and 
# two columns
#
par(mfrow=c(2,2))
#
# the first plot will be that of Global_active_power versus day of the week and
# will be in the upper left (row one, column one). This is the plot created in
# plot2.R
#
plot(daysOfInterest$Global_active_power ~ posixTimesOfDay, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
#
# the second plot will be that of voltage versus day of the week and will be
# upper right (row one, column two), following a clockwise pattern. This is a 
# new line plot and will label the y-axis as "Voltage" and the x-axis as 
# "datetime"
#
plot(daysOfInterest$Voltage ~ posixTimesOfDay,
     ylab="Voltage",xlab="datetime",type="l")
#
# the third plot will be that of energy sub metering versus day of the week and 
# will be in the lower left (row two, column one), following a clockwise pattern.
# This is the plot from Plot3.R and will plot three plots in one
#
plot(daysOfInterest$Sub_metering_1 ~ posixTimesOfDay,
     ylab="Energy sub metering", xlab="",col="black",type="l")
lines(daysOfInterest$Sub_metering_2 ~ posixTimesOfDay,col="red")
lines(daysOfInterest$Sub_metering_3 ~ posixTimesOfDay,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=.3, col=c("black", "red", "blue"),bty="n")
# 
# the fourth plot will be that of Global_reactive_power versus day of the week and
# will be in the lower right (row two, column two), following a clockwise pattern.
# This is anew line plot and will label the y-axis as "Global_reactive_power"
# and the x-axis as "datetime"
# 
plot(daysOfInterest$Global_reactive_power ~ posixTimesOfDay,
     ylab="Global_reactive_power",xlab="datetime",type="l")
#
# save the produced histogram to a PNG file with a width of 480 pixels and a 
# height of 480 pixels
#
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
