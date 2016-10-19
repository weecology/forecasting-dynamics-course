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

# But we know this isn't right

acf(NDVI_ts)
pacf(NDVI_ts)

# So let's build a model that takes this autocorrelation into account
# Autoregressive model
# Forecast variable based on  based on previous states in time-series
#
# y_t = c + b1 * y_t-1 + b2 * y_t-2 ... + e_t

arima_model = Arima(NDVI_ts, c(2, 0, 0))
plot(NDVI_ts)
lines(fitted(arima_model), col = 'red')

# How is it doing
plot(resid(arima_model))
acf(resid(arima_model))

# Still has autocorrelation at 1 and 2 years, so maybe some seasonal signal

seasonal_arima_model = Arima(NDVI_ts, c(2, 0, 0), seasonal = c(2, 0, 0))
plot(NDVI_ts)
lines(fitted(seasonal_arima_model), col = 'red')
acf(resid(seasonal_arima_model))

# Automating fits
# Fit many possible values of seaonsla, AR, differencing, and MA, and pick the best
# Unit root tests, minimization of the AICc and MLE

# START WITH SEASONAL = FALSE, NOTE 1 AND 2 YEAR AUTOCORRELATION, REMOVE

arima_model = auto.arima(NDVI_ts, seasonal = FALSE)
plot(NDVI_ts)
lines(fitted(arima_model), col='red')
model_forecast = forecast(arima_model)
acf(resid(arima_model))
Box.test(resid(arima_model))

# Incorporating external co-variates
# y_t = c + b1 * y_t-1 + b2 * x_t ... + e_t

rain_arima_model = auto.arima(NDVI_ts, xreg = rain_ts)
plot(NDVI_ts)
lines(fitted(rain_arima_model), col = 'blue')
lines(fitted(arima_model), col = 'red')

# What are those other two numbers

# Differencing: handles strong one-step autocorrelations
# Moving average: autocorrelated errors
