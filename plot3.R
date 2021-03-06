library(tidyr)
library(tidyverse)
library(lubridate)

# Download and load the datasets

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileurl, destfile = "powerconsumption.zip")

unzip("powerconsumption.zip")

data <- read_csv2("household_power_consumption.txt")

# Subsetting the data

data1 <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

# Create a DateTime Variable and Convert Global active power variable to numeric

data2 <- data1 %>% 
  mutate(
    DateTime = dmy_hms(paste(Date, Time)),
    Global_active_power = as.numeric(Global_active_power), 
    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),
    Sub_metering_3 = as.numeric(Sub_metering_3)
  )

# Creating Plot 3

glimpse(data2)

with(data2, plot(type = "n", DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab = ""))
with(data2, lines(DateTime, Sub_metering_1, col = "black"))
with(data2, lines(DateTime, Sub_metering_2, col = "red"))
with(data2, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2 , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)

dev.off()
