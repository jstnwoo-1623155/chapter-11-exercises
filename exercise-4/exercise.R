# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")
#library(dplyr)
library(nycflights13)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
View(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
gain_loss_time_flying <- mutate(flights, arrival_time_difference = (arr_time - sched_arr_time))

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
gain_loss_time_flying <- arrange(gain_loss_time_flying, -arrival_time_difference)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
gain_lost_time_flying <- mutate(flights, arrival_time_difference = (arr_time - sched_arr_time)) %>%  arrange(-arrival_time_difference)

# Make a histogram of the amount of time gained using the `hist()` function
#hist(flights$arr_delay)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
summarize(flights, mean = mean(arr_delay, na.rm = TRUE))

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
seatac_flights <- filter(flights, dest == "SEA") %>% mutate(gain_in_air = (arr_time - sched_arr_time)) %>% select(origin, dest, gain_in_air)

# On average, did flights to SeaTac gain or loose time?
summarize(seatac_flights, mean = mean(gain_in_air, na.rm = TRUE))

# On average flights lost time, -45.44325 minutes

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
seatac_flights_from_JFK <- filter(flights, dest == "SEA", origin == "JFK") %>% summarize(min_time = min(air_time, na.rm = TRUE), max_time = max(air_time, na.rm = TRUE), mean = mean(air_time, na.rm = TRUE))
