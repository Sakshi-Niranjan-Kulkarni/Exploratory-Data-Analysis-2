# Download the file
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile1 <- "destfile.zip"

if(!file.exists(destfile1)) {
    download.file(url1, 
                  destfile = destfile1, 
                  method = "curl")
    unzip(destfile1, exdir = ".")
}

# Load the NEI & SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
baltimoreNEI <- NEI[NEI$fips=="24510",]

# Aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

png("plot2.png",width=480,height=480,units="px",bg="transparent")

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()
