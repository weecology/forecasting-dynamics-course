library(forecast)

# Data setup

data = read.csv("portal_timeseries.csv", stringsAsFactors = FALSE)
head(data)
NDVI_ts = ts(data$NDVI, start = c(1992, 3), end = c(2014, 11), frequency = 12)
rain_ts = ts(data$rain, start = c(1992, 3), end = c(2014, 11), frequency = 12)
# Plot the data

plot(NDVI_ts)

# Most basic time-series model
# Normally distributed data w/fixed mean and variance
# No change time-series is just random samples
#
# y = c + e_t, where e_t ~ N(0, sigma)

avg_model = meanf(NDVI_ts)
plot(NDVI_ts)
lines(fitted(avg_model), col = 'red')
summary(avg_model)

# But we know this isn't righty

acf(NDVI_ts)
pacf(NDVI_ts)

# So let's build a model that takes this autocorrelation into account
# Autoregressive model
# Forecast variable based on  based on previous states in time-series
#
# y_t = c + b1 * y_t-1 + b2 * y_t-2 ... + e_t
#
# Does this remind you of a biological model?
# This model is bascially a Gompertz population model if y is log(N)
#
# ARIMA: autoregressive, integrated, moving average

arima_model = Arima(NDVI_ts, c(2, 0, 0))
plot(NDVI_ts)
lines(fitted(arima_model), col = 'red')
summary(arima_model)

# How is it doing
plot(resid(arima_model))
acf(resid(arima_model))

# Still has autocorrelation at 1 and 2 years, so maybe some seasonal signal
# Seasonal component is modeled in the same way, but in 1 full season steps
#
# y_t = constant + b1 * y_t-1 + b2 * yt_2 + b3 * y_t-12 + b4 * y_t-24 + e_t

seasonal_arima_model = Arima(NDVI_ts, c(2, 0, 0), seasonal = c(2, 0, 0))
plot(NDVI_ts)
lines(fitted(seasonal_arima_model), col = 'red')
summary(seasonal_arima_model)
acf(resid(seasonal_arima_model))

# Build seasonal and non-seasonal ARIMAs for the precipitation data

# Automating fits
# Fit many possible values of seasonal, AR, differencing, and MA, and pick the best
# Unit root tests, minimization of the AICc and MLE

arima_model = auto.arima(NDVI_ts)
plot(NDVI_ts)
lines(fitted(arima_model), col='red')
summary(arima_model)

acf(resid(arima_model))
Box.test(resid(arima_model))

# What are those other two numbers

# Differencing: handles strong one-step autocorrelations, like trends
# Moving average: autocorrelated errors

# Can use `seasonal = FALSE` to skip seasonal signal

# Incorporating external co-variates
# y_t = c + b1 * y_t-1 + b2 * x_t ... + e_t

rain_arima_model = auto.arima(NDVI_ts, xreg = rain_ts)
plot(NDVI_ts)
lines(fitted(rain_arima_model), col = 'blue')
lines(fitted(arima_model), col = 'red')
