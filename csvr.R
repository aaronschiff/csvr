csvr = function(csvFile, ...) {
  # Setup
  library(dplyr)
  library(ggplot2)
  
  # Read data
  if (!missing(csvFile)) {
    csvData = read.csv(csvFile, ...)
  }
}