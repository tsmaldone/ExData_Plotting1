#
# Exploratory Data Analysis - Project #1
#
# plot3.R
#
# Using the household_power_consumption data from the "Individual household
# electric power consumption Data Set", this routine will create one plot
# to include the Sub_metering_1, Sub_metering_2 and Sub_metering_3 variables
# (corresponding to the watt-hour of active energy for the kitchen, laundry
# room and water-heater / air-conditioner, respectively) for the dates
# 01 Feb 2007 and 02 Feb 2007 (a Thursday and Friday)
#
# From an exploratory data analysis perspective the plots show that the highest 
# energy usage, by far, was in the kitchen, but only during the late afternoon,
# early evening, and only on Thurday (times for cooking, etc. and perhaps on
# Friday, people eat out?). Consisteny, though, was the energy usage for the
# water heater (certainly not air-conditioner in February!) during the morning
# and afternoon / evening hours (showers, generating hot water for the laundry,
# dishwasher, etc.). The lowest energy usage was for the laundry room, but it was 
# consistent, perhaps due to the refrigerator being included in this, which would
# run periodically through-out the day. These plots, show the relativity between
# these usage areas and are as one would expect.
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
# First create the plot of Sub_metering_1 versus day of the week, with the
# appropriate y-axis label, no x-axis label, using black lines
#
plot(daysOfInterest$Sub_metering_1 ~ posixTimesOfDay, type="l",
     ylab="Energy sub metering", xlab="",col="black")
#
# Next, using "lines" add the plots of Sub_metering_2 and Sub_metering_3
# versus the day of the week with line colors red and blue, respectively
#
lines(daysOfInterest$Sub_metering_2 ~ posixTimesOfDay,col="red")
lines(daysOfInterest$Sub_metering_3 ~ posixTimesOfDay,col="blue")
#
# Provide a legend in the upper right-hand corner for the three line plots,
# sizing the legend box appropriately
#
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, cex=.75, col=c("black", "red", "blue"))
#
# save the produced histogram to a PNG file with a width of 480 pixels and a 
# height of 480 pixels
#
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
