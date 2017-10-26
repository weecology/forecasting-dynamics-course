---
layout: nil
---

# Evaluating forecasts

## Steps in forecasting

1. Problem definition
2. Gather information
3. Exploratory analysis
4. Choosing and fitting models
5. Make forecasts
6. **Evaluate forecasts**

## Setup

```
library(forecast)
library(ggplot2)

data = read.csv("portal_timeseries.csv", stringsAsFactors = FALSE)
head(data)
NDVI_ts = ts(data$NDVI, start = c(1992, 3), end = c(2014, 11), frequency = 12)
plot(NDVI_ts)
acf(NDVI_ts)

```

## Hindcasting

### Test and training data

```
NDVI_train <- window(NDVI_ts, end = c(2011, 11))
NDVI_test <- window(NDVI_ts, start = c(2011, 12))
```

### Build model on training data

```
arima_model = auto.arima(NDVI_train, seasonal = FALSE)
```

### Make forecast

```
arima_forecast = forecast(arima_model, h = 36)
```

## Visualize

### Time-series

```
plot(arima_forecast)
lines(NDVI_test)
```

### Observed-predicted

```
plot(arima_forecast$mean, NDVI_test)
plot(as.vector(arima_forecast$mean), as.vector(NDVI_test))
abline(0, 1)
```

## Quantify

```
accuracy(arima_forecast, NDVI_test)
```

* Errors higher on test than training data because training data is being fit
* Brier Score == RMSE^2
* Common method for evaluating forecasts

> Visualize and quantify the accuracy of the seasonal ARIMA model

```
seasonal_arima_model = auto.arima(NDVI_train)
seasonal_arima_forecast = forecast(seasonal_arima_model, h = 36)
plot(seasonal_arima_forecast)
lines(NDVI_test)
plot(as.vector(seasonal_arima_forecast$mean), as.vector(NDVI_test))
abline(0, 1)
seasonal_accur <- accuracy(seasonal_arima_forecast, NDVI_test)
```

### Coverage

```
in_interval <- arima_forecast$lower[,1] < NDVI_test & arima_forecast$upper[,1] > NDVI_test
coverage <- sum(in_interval) / length(NDVI_test)
```

### Compare

```
data.frame(arima = arima_accur[2,], seasonal = seasonal_accur[2,])
in_interval_season <- seasonal_arima_forecast$lower[,1] < NDVI_test & seasonal_arima_forecast$upper[,1] > NDVI_test
coverage_season <- sum(in_interval_season) / length(NDVI_test)
coverage
coverage_season
```

## Forecast horizon

```
plot(sqrt((arima_forecast$mean - NDVI_test)^2))
lines(sqrt((seasonal_arima_forecast$mean -  NDVI_test)^2), col = 'blue')
```
