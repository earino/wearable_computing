# download.R
#
# This script provides a basic file download function for the master data set. It will
# download it from the appropriate site, as stated on the problem definition page, and
# once it verifies that the downloaded file has the expected md5sum, it will then 
# store it as the master data archive.

library(tools)

md5sum      <- "d29710c9530a31f303801b6bc34bd895"
outFile     <- "Dataset.zip"
outFileTmp  <- "Dataset.zip.tmp"
outDir      <- paste0(getwd(),"/downloads")
sourceUrl   <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(outDir)) {
  dir.create(outDir)
}

destfile    <- paste0(outDir,"/",outFileTmp)
masterfile  <- paste0(outDir,"/",outFile)

download.file(url=sourceUrl, destfile=destfile, method="curl")
sum <- md5sum(files=destfile)

if (sum != md5sum) {
  stop("Unwilling to overwrite master data set, md5sum does not match expected value.")
}

if (file.exists(masterfile)) {
  file.remove(masterfile)
}

file.rename(from=destfile, masterfile)