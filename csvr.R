# Count unique levels of each categorical variable using dplyr functions
count_categorical = function(d) {
  for (n in names(d)) {
    if (typeof(d[[n]]) == "character") {
      y = d %>% group_by(value = d[[n]]) %>% summarise(count = n())
      print(n)
      print(y)
    }
  }
}


# Main analysis function
csvr = function(csv_file, ...) {
  # Setup
  library(dplyr)
  library(ggplot2)
  
  # Read data
  if (!missing(csv_file)) {
    csv_data = read.csv(csv_file, stringsAsFactors = FALSE, ...)
    
    if (nrow(csv_data) > 0) {
      counts = count_categorical(csv_data)
    }
  }
}

csvr("gdp.csv")