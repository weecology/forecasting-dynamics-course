library(forecast)
library(ggplot2)

# Data setup

data = read.csv("portal_timeseries.csv", stringsAsFactors = FALSE)
head(data)
NDVI_ts = ts(data$NDVI, start = c(1992, 3), end = c(2014, 11), frequency = 12)

# Steps in forecasting
# 1. Problem definition
# 2. Gather information
# 3. Exploratory analysis
# 4. Choosing and fitting models
# 5. Make forecasts
# 6. Evaluate forecasts

# Reminder of data structure

plot(NDVI_ts)
acf(NDVI_ts)

# Last time we made some models, the simplest was just the average
# Average model: y_t = c + e_t, where e_t ~ N(0, sigma)

# To make forecasts from these models we ask what the model would predict at the time-step of interest
# So, for the average model we just need to know what c is, which is just the mean(NDVI_ts)

mean(NDVI_ts)

# If we use `meanf` to get a forecast for the average model we see that this mean is the forecast value

avg_forecast = meanf(NDVI_ts)
avg_forecast

# Look at the forecast object

str(avg_forecast)

# Can see the
# * Method used for forecasting
# * Values for fitting the model
# * Information about the model
# * Mean values for the forecast

# The expected value, or point forecast, is in $mean

avg_forecast$mean

# Visualize

plot(NDVI_ts)
lines(avg_forecast$mean, col = 'pink')

# Better to use built-in plotting functions

plot(avg_forecast)

# or

autoplot(avg_forecast)

# Change the number of time-steps in the forecast using h

avg_forecast = meanf(NDVI_ts, h = 50)
plot(avg_forecast)

# Uncertainty
# Important to know how confident our forecast is
# Shaded areas provide this information
# Only variation in e_t is included, not errors in parameters
# By default 80% and 95%

avg_forecast
avg_forecast <- meanf(NDVI_ts, level = c(50, 95))
avg_forecast
plot(avg_forecast)

# Does it look like 95% of the empirical points fall within the gray band?
# Might make us sceptical of this forecast
# How do we tell? We'll come back to this when we learn how to evaluate forecasts

# Forecasting with more complex models
# `forecast()` function
# Non-seasonal ARIMA
# y_t = c + b1 * y_t-1 + b2 * y_t-2 + e_t
# Actually y_t = (1 - b1 - b2)*c + b1 * y_t-1 + b2 * y_t-2 + e_t due to non-zero mean

arima_model = auto.arima(NDVI_ts, seasonal = FALSE)
arima_model
arima_forecast = forecast(arima_model)
plot(arima_forecast)

# Can see the model at work
# First step influenced strongly postively by previous time-step which is high so above mean
# Second step is pulled below negative AR2 parameter
# Gradually reverts to the mean

# You Do
# Make a forecast using a seasonal ARIMA model (the best model we found last time)
# Make the forecast for 3 years (36 months into the future)
# Show the 80 and 99% prediction intervals

seasonal_arima_model = auto.arima(NDVI_ts)
seasonal_arima_forecast = forecast(seasonal_arima_model, h = 36, level = c(80, 99))
plot(seasonal_arima_forecast)

# Forecasts from cross-sectional approach

library(dplyr)
library(tidyr)

monsoon_data <- data %>%
  separate(date, c("month", "day", "year"), sep = '/') %>%
  filter(month == 7 | month == 8 | month == 9) %>%
  group_by(year) %>%
  summarize(monsoon_rain = sum(rain), monsoon_ndvi = mean(NDVI), monsoon_rodents = sum(rodents))

ggplot(monsoon_data, aes(x = monsoon_rain, y = monsoon_ndvi)) +
  geom_point() +
  geom_smooth(method = "lm")

rain_model = lm('monsoon_ndvi ~ monsoon_rain', data = monsoon_data)
rain_forecast = forecast(rain_model, newdata = data.frame(monsoon_rain = c(120, 226, 176, 244)))
plot(rain_forecast)
