# Analyse categorical variables in a CSV file

# Count unique values of each categorical variable using dplyr functions
# Optionally plot the counts on bar charts
# Returns a list of lists (variable_name, values) where variable_name is the name of the
# categorical variable and values is a dataframe having columns value and count. 
count_categorical = function(d, plot_results = TRUE, max_plot_results = 25) {
  results = vector("list", length(names(d)))
  
  i = 1
  for (n in names(d)) {
    if (typeof(d[[n]]) == "character") {
      y = d %>% group_by(value = d[[n]]) %>% summarise(count = n()) %>% as.data.frame()   # Count unique values
      r = list(variable_name = n, values = y)
      results[[i]] = r
      i = i + 1
    }
  }
  
  if (plot_results) {
    # For each categorical variable, draw a bar chart of its values
    for (r in results) {
      if (!is.null(r)) {
        # Create temporary dataframe of values and counts, and sort it by count
        rdf = transform(r$values, value = reorder(value, count))
        
        # Truncate rdf if necessary
        if (nrow(rdf) > max_plot_results) {
          rdf = rdf[1:max_plot_results, ]
        }
        
        # Plot bar chart using ggplot
        bar_chart = ggplot(rdf, aes(x = value, y = count)) +
                    geom_bar(stat = "identity") +
                    coord_flip() + 
                    ggtitle(r$variable_name) + 
                    theme(
                      axis.line = element_blank(), 
                      axis.ticks.x = element_blank(), 
                      axis.ticks.y = element_blank(), 
                      axis.title.x = element_blank(), 
                      axis.title.y = element_blank(), 
                      panel.background = element_blank(), 
                      panel.grid.major.x = element_line(colour = "#eeeeee")
                    )
        print(bar_chart)
      }
    }
  }
  
  return(results)
}


# Main analysis function
csvr = function(csv_file, plot_results = TRUE, max_plot_results = 25, ...) {
  # Setup
  library(dplyr)
  library(ggplot2)
  
  # Read data
  if (!missing(csv_file)) {
    csv_data = read.csv(csv_file, stringsAsFactors = FALSE, ...)
    
    if (nrow(csv_data) > 0) {
      counts = count_categorical(csv_data, plot_results, max_plot_results)
      
      return(counts)
    }
  }
}

y = csvr("gdp.csv")