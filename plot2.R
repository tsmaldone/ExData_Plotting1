#
# Exploratory Data Analysis - Project #1
#
# plot2.R
#
# Using the household_power_consumption data from the "Individual household
# electric power consumption Data Set", this routine will create a plot
# of the Global_active_power variable (the household global minute-averaged
# active power (in kilowatt)) for the dates 01 Feb 2007 and 02 Feb 2007 (a 
# Thursday and Friday)
#
# From an exploratory data analysis perspective the plot shows that the highest 
# minute-averaged power usage occurred during the mid-day and evening hours, as
# one would expect.
#
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
# Plot the Global_active_power data versus the days of the week corresponding
# to the above days of interest, supplying the appropriate y-axis label and
# creating a line plot
#
plot(daysOfInterest$Global_active_power ~ posixTimesOfDay, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
#
# save the produced histogram to a PNG file with a width of 480 pixels and a 
# height of 480 pixels
#
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
