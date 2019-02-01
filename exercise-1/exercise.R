# Exercise 1: working with data frames (review)

# Install devtools package: allows installations from GitHub
#install.packages("devtools")

# Install "fueleconomy" dataset from GitHub
#devtools::install_github("hadley/fueleconomy")

# Use the `libary()` function to load the "fueleconomy" package
#library(fueleconomy)

# You should now have access to the `vehicles` data frame
# You can use `View()` to inspect it
View(vehicles)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
vehicle_makes <- vehicles[, c ("make")]

# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
car_manufacturers <- print(length(unique(vehicle_makes)))

# Filter the data set for vehicles manufactured in 1997
vehicle_1997 <- print(vehicles[vehicles$year == 1997,])

# Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
# vehicle_hwy <- print(order(vehicle_1997[vehicle_1997$hwy, ]))
vehicle_hwy <- print(vehicle_1997[order(vehicle_1997$hwy),])

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
vehicle_hwy$average <- rowMeans(vehicle_hwy[,c("hwy", "cty")], na.rm=TRUE)

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
vehicle_2wheels <- vehicles[(vehicles$drive == "2-Wheel Drive"), ]
vehicle_2wheels <- vehicle_2wheels[vehicle_2wheels$cty >=20, ]

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
worst_2wheels_mpg <- vehicle_2wheels[vehicle_2wheels$hwy == min(vehicle_2wheels$hwy), "id" ]

# Write a function that takes a `year_choice` and a `make_choice` as parameters, 
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
best_car <- function(year_choice, make_choice) {
  df <- vehicles[vehicles$make == make_choice, ]
  df <- df[(df$year == year_choice), ]
  df <- df[order(df$hwy, decreasing = TRUE),]
  return(df[1, "model"])
}


# What was the most efficient Honda model of 1995?
xxx <- best_car(1995, "Honda")
