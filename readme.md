# csvr: Analyse categorical variables in a CSV file

This R code analyses the unique levels of all of the categorical variables in a csv file.

A categorical variable is defined to be one of “character” type after the csv file has been read (`stringsAsFactors` is forced to `FALSE`).

The packages dplyr and ggplot2 are required.

The primary output is a list with:

_$variable_names_: A list of the names of categorical variables in the csv file.

_$results_: A list of `($variable_name, $values)` for each categorical variable, where `$values` is another list of `($value, $count)` for that variable. The `$value` vector gives each unique value of the variable and `$count` gives the number of times each value appears in the dataset.

## Usage
`csvr(csv_file, plot_results = TRUE, max_plot_results = 25, max_plot_value_length = 50, …)`

_csv_file_: The name of the CSV file to analyse

_plot_results_: If TRUE, a bar chart is produced for each categorical variable showing the number of time that each unique value of that variable appears in the csv file.

_max_plot_results_: The maximum number of unique values that are plotted for each categorical variable if plot_results is TRUE. Note that all of the results are returned in the output data regardless of the setting of this variable.

_max_plot_value_length_: If the strings for the values of categorical variables are longer than this setting, they will be truncated on the plots. This only affects plotting; full names are returned in the output data. 

## TODO
Add an optional list of variable names that are skipped in the analysis.

Analyse hierarchical relationships among categorical variables, assuming a left -> right hierarchy of colums in the csv file.
