# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

View(flights)
View(airports)
View(airlines)
# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
average_delays <- flights %>% group_by(dest) %>% summarize(dest_avg = mean(arr_delay, na.rm = TRUE)) %>% left_join(airports, average_delays, by = c("dest" = "faa"))

# Columbia Metropolitan

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
average_airline_delay <- flights %>% group_by(carrier) %>% summarize(airline_avg = mean(arr_delay, na.rm = TRUE)) %>% left_join(airlines, average_delays, by = "carrier")

# Alaska Airlines Inc.