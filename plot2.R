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
    Global_active_power = as.numeric(Global_active_power)
  )

# Creating Plot 2

glimpse(data2)

plot(type = "l", data2$DateTime, data2$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png", width = 480, height = 480)

dev.off()
