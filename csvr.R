#------------------------------------------------------------------------------
# Analyse categorical variables in a CSV file
# A categorical variable has character type
# Requires dplyr and ggplot2


#------------------------------------------------------------------------------
# Count unique values of each categorical variable using dplyr functions
# Optionally plot the counts on bar charts
# Returns variable_names: a list of the categorical variable names
#         results: lists (variable_name, values) giving the counts of values of
#                  the categorical variables
count_categorical = function(d, plot_results = TRUE, max_plot_results = 25, max_plot_value_length = 50) {
  # Placeholder for return values
  data_info = NULL
  
  # Select character columns from d and get names of these
  categorical_data = d[, sapply(d, class) == "character"]
  data_info$variable_names = names(categorical_data)
  
  # Count unique values of categorical variables
  data_info$results = vector("list", length(data_info$variable_names))
  i = 1
  for (n in names(categorical_data)) {
    y = d %>% group_by(value = categorical_data[[n]]) %>% summarise(count = n()) %>% as.data.frame()   # Count unique values
    r = list(variable_name = n, values = y)
    data_info$results[[i]] = r
    i = i + 1
  }
  
  if (plot_results) {
    # For each categorical variable, draw a bar chart of its most frequent values
    for (r in data_info$results) {
      if (!is.null(r)) {
        # Create temporary dataframe of values and counts, and sort it by count
        rdf = transform(r$values, value = reorder(value, count))
        
        # Truncate rdf rows if necessary
        if (nrow(rdf) > max_plot_results) {
          rdf = rdf[1:max_plot_results, ]
        }
        
        # Truncate value strings if necessary
        shorten = function(x, max_length) {
          if (nchar(x) > max_length) {
            x = strtrim(x, max_length)
            x = paste(x, " ...")
          }
          return(x)
        }
        # rdf$value = lapply(rdf$value, shorten)
        
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
  
  return(data_info)
}


#------------------------------------------------------------------------------
# Main analysis function
csvr = function(csv_file, plot_results = TRUE, max_plot_results = 25, max_plot_value_length = 50, ...) {
  # Setup
  library(dplyr)
  library(ggplot2)
  
  # Read data
  if (!missing(csv_file)) {
    csv_data = read.csv(csv_file, stringsAsFactors = FALSE, ...)
    
    if (nrow(csv_data) > 0) {
      counts = count_categorical(csv_data, plot_results, max_plot_results, max_plot_value_length)
      
      return(counts)
    }
  }
}


#------------------------------------------------------------------------------
# Run with test data
y = csvr("gdp.csv")
