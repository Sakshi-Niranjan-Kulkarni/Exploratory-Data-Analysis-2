# Download the file
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile1 <- "destfile.zip"

if(!file.exists(destfile1)) {
    download.file(url1, 
                  destfile = destfile1, 
                  method = "curl")
    unzip(destfile1, exdir = ".")
}

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate by sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.off()
