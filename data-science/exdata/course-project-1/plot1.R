# Read the full dataset
if (file.exists("household_power_consumption.txt")) {
  raw.data <- read.csv("household_power_consumption.txt", sep=";", 
                       stringsAsFactors = FALSE, na.strings = "?")
} else {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  raw.data <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", 
                       stringsAsFactors = FALSE, na.strings = "?")
  unlink(temp)
}

# Subset the data
raw.data$Date <- as.Date(raw.data$Date, format = "%d/%m/%Y")
data <- subset(raw.data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(raw.data) 

# Convert the Date and Time variables to Date/Time classes
data$datetime  <- as.POSIXct(paste(data$Date, data$Time, sep=" "))

# Create the plot
par(mfrow=c(1,1))
with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
                main="Global Active Power"))

# Create the PNG file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
