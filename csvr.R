# Count unique levels of each categorical variable
countCategorical = function(d) {
  for (n in names(d)) {
    if (typeof(d[[n]]) == "character") {
      print(n)
    }
  }
}


# Main analysis function
csvr = function(csvFile, ...) {
  # Setup
  library(dplyr)
  library(ggplot2)
  
  # Read data
  if (!missing(csvFile)) {
    csvData = read.csv(csvFile, stringsAsFactors = FALSE, ...)
    
    if (nrow(csvData) > 0) {
      counts = countCategorical(csvData)
    }
  }
}

csvr("gdp.csv")