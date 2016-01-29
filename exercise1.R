### Exercise 1 ###

# Install the nycflights13 package and read it in.  Require the dplyr package
# install.packages("nycflights13")
install.packages('nycflights13')
library(nycflights13)
library(dplyr)

# The data.frame flights should now be accessible to you.  View it, 
# and get some basic information about the number of rows/columns
View(flights)
dim(flights)
nrow(flights)
ncol(flights)

# Add a column that is the amount of time gained in the air
flights <- mutate(flights, time_gained = arr_delay - dep_delay)

# Sort your data.frame desceding by the column you just created
flights <- arrange(flights, desc(time_gained))

# Try doing the last 2 steps in a single operation using the pipe operator
flights <- flights %>% mutate(time_gained = arr_delay - dep_delay) %>% arrange(desc(time_gained))

# Make a histogram of the amount of gain using the `hist` command
hist(flights$time_gained)

# On average, did flights gain or lose time?
mean(flights$time_gained, na.rm = TRUE)

# Create a data.frame of flights headed to seatac ('SEA'), 
# and only include the column you just created
to_seatac <- flights %>% select(time_gained, dest) %>% filter(dest == "SEA")

# On average, did flights to seatac gain or loose time?
mean(to_seatac$time_gained, na.rm = TRUE)

# Write a function that allows you to specify an origin, a destination, and a column of interest
# that returns a data.frame of flights from the origin to the destination and only the column of interest
## Hint: see slides on standard evaluation
interest <- function(the_origin, the_dest, interest) {
  res <- flights %>% filter(origin == the_origin, dest == the_dest) %>% select_(interest)
  return(res)
}

# Retireve the air_time column for flights from JFK to SEA
jfk_to_sea <- interest("JFK", "SEA", "air_time")

# What was the average air time of those flights (in hours)?  What was the min/max?
# divide by 60 for hour measurement
mean(jfk_to_sea$air_time, na.rm = TRUE) / 60
min(jfk_to_sea$air_time, na.rm = TRUE) / 60
max(jfk_to_sea$air_time, na.rm = TRUE) / 60

### Bonus ###
# Rewrite the function above to return a list of the min, max, and mean values of the column of interest


# Calculate the departure delays from JFK to DEN

