#
# plot1.R
#
# Using the household_power_consumption data from the "Individual household
# electric power consumption Data Set", this routine will create a histogram
# of the Global_active_power variable (the household global minute-averaged
# active power (in kilowatt)) for the dates 01 Feb 2007 and 02 Feb 2007
#
# From an exploratory data analysis perspective the histogram that, by far, the
# most frequent minute-averaged power usage was in the 0.5 kilowatt range.
#
# Tony Smaldone
# June 2, 2015
#
# read in the data, using the ";" as the field separator and removing and missing
# values from the data set (coded as a "?")
#
allData <- read.csv("household_power_consumption.txt",sep=";",na.strings="?")
#
# Subset the data to include only the data for the above specified dates
# Note: To create the histogram does not require conversion of the date to
# that of class Date
#
# To accomplish this, will use, what I call, a recursive subset
#
daysOfInterest<-subset(allData,subset=(Date == "1/2/2007" | Date == "2/2/2007"))
#
# create the histogram, which is the frequency of household global minute-averaged
# active power with bin width of 0.5. Label as appropriate the x- and y-axes,
# supply a main title and color the bars of the histogram red
#
hist(daysOfInterest$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
#
# save the produced histogram to a PNG file with a width of 480 pixels and a 
# height of 480 pixels
#
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
