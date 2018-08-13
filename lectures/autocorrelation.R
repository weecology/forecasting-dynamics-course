library(forecast)
library(astsa)

# Last week we talked about the different time scales as one type of signal that
# was embedded in a timeseries. This week we're going to talk about a different
# issue with time scales. 

# Let's start by thinking about an extreme case ofa time series. Say I have a normal distribution
# centered on zero and at each time step I randomly draw a value from the distribution
# what does my time series look like? (highly variable, no trend). 

# Is this how we would expect a normal biological time series to operate? (no. the value
# at t+1 probably has some dependence on the value at t)

# So let's look at a random time series where the value at one time step has
# no dependence on the previous time step. This gives us a signal that we typically
# call white noise.

set.seed(20)
whitenoise <- ts(rnorm(273))          
plot(whitenoise, main="White noise")

# rnorm generates a vector of numbers randomly drawn from a normal distribution
# with mean = 0 and sd = 1

data = read.csv('portal_timeseries.csv')
head(data)
NDVI.ts = ts(data$NDVI, start = c(1992, 3), end = c(2014, 11), frequency = 12)
plot(NDVI.ts, xlab = "Year", ylab="greenness", main="NDVI")


# clearly the biological time series and the white noise series look different
# from last week, we know that the NDVI data has seasonality in the signal, so
# that's clearly one major difference, related to that is that the value at one
# time step is not necessarily indpendent from previous time steps. We can
# explore that dependence by looking at lag plots.How much does one time step 
# tell you about the next?

# Lag plots are simply the correlation between values at time t and some time step in
# the past. The difference btween time t and a value inthe past is the lag. 

# So here, let's plot all the lags up to 12 months.
lag.plot(NDVI.ts, lags=12, do.lines=FALSE)

# The lag.plot is showing you the autocorrelation within a time series. WHich
# is great as a data viz step, but hard to interpret more precisely than to see
# how the time series is related to itself and when things look more strongly related

# At each one of these lags, we could calculated a correlation coefficient between the data at
# time 2 and some number of lags in the past. 

# an autocorrelation function or ACF or correlogram conducts those correlationns  and plots them
# in a way that makes the autocorrelation structure of the time series easier to understand

acf(NDVI.ts)

# A time series should always give you a correlation coefficient of 1 at a zero time lag, depending
# on the package you use, you may or may not get the 0 lag coefficient.So just make sure you check before
# you get excited about having a strong signal

# In this case, the x axis is the proportion of the annual frequency 
# for the NDVI time series, but sometimes this is displayed in the actual units of the timeseries (months in our case)
# For our NDVI time series, the strongest correlation is at a lag of 1 month, and then the
# autocorrelation in the time series drop off substantially. We get little blips every 12
# months which is the seasonality coming through and perhaps a weak signal of a negative relationship
# at 6 month lags. What might that mean, biologically?

# the blue lines plotted are the 95% confidence interval for the autocrrelation of
# a time series (+- 1.96/(sqrt(T))). If more than 5% of spikes are outside this bound,
# your time series is probably not white noise. 

lag.plot(whitenoise, lag = 12, do.lines = FALSE)
acf(whitenoise)

# If there's a pattern to your spikes,
# that is usually another good sign that you have autocorrelation structure in your 
# time series

lag.plot(whitenoise, lag = 12, do.lines = FALSE)
acf(whitenoise)

# HAVE STUDENTS LOAD data, create a TS object AND PLOT PPT AND RODENTS
# Check first and last dates, frequency, sorted

PPT.ts = ts(data$rain, start=c(1992,3), end = c(2014,11), frequency=12)
lag.plot(PPT.ts, lags=12, do.lines=FALSE)
acf(PPT.ts)

rats.ts = ts(data$rodents, start=c(1992,3), end = c(2014,11), frequency=12)
lag.plot(rats.ts, lags=12, do.lines=FALSE)
acf(rats.ts)

# Autocorrelation can echo through a time series. If Y_t and Y_t-1 are strongly correlated
# and Y_t-1 and Y_t-2 are strongly correlated then presumably Y_t and Y_t-2 are correlated 
# even if there is no causal factor involved. We can examine this by using a partial acf. In fact
# the correlation at lag2 is the square of the correlation at lag 1. 

# pacf takes this relationship into account and gives you the correlation coefficient between t and t-2 once
# you account for the relationship between t and t-1.

acf(NDVI.ts)
pacf(NDVI.ts) # note pacf starts at lag1 not 0 so this can confuse people

# FOrecast package has a nice feature that let's you look at the time series, the acf, and pacf at the same time
tsdisplay(NDVI.ts)

# Let students do this for rodents and rain
tsdisplay(rats.ts)
tsdisplay(PPT.ts)

# The rodents show a classic signal of an autoregressive model. WHat is an autoregressive model?
# Something where the value at time t depends on the values at previous time steps. 

# A classic autoregressive model is a random walk:
set.seed(1)
x = w = rnorm(1000)
for (t in 2:1000) x[t] = x[t-1]+w[t]
tsdisplay(x)

# you can use these plots to get a better understanding of your time series. What dynamics are occurring?
# What questions might be worth asking or what is surprising to you that doesn't seem to be coming through?

# Understanding your autocorrrelation structure is also important statistically
# Regression approaches with autocorreated data will give underestimates of the variance
# inflated test statsitics, and narrow CIs.
# Many time series techniques require your time series to be stationary. 


# Finally, sometimes you want to understand how two time series are correlated
# across different lags. You can use the cross-correlation function to dig into that

ccf.plantsrain = ccf(PPT.ts, NDVI.ts)
lag2.plot(PPT.ts, NDVI.ts, 12)

ccf.plantrat = ccf(NDVI.ts, rats.ts)
lag2.plot(NDVI.ts, rats.ts, 12)

# Some take home messages for autocorrelation: 
# 1. Autocorrelation is useful in that information about the past and future states
#    of the system are encoded in the timeseries. This is information that can
#    potentially be leveraged for forecasting.
# 2. Autocorrelation is a statistical pain in the butt. Statistical approaches
#    Assume iid: independent and identically distributed errors. i.e. that your
#    data is a random draw from an underlying distribution. But autocorrelation
#    means that your data is not a random draw. Each draw is influenced by the
#    previous draw. This means that if you put a time series through a regression
#    your confidence intervals will be smaller than they should be. Parameter
#    estimates areok. Need to deal with that autocorrelation for statsitical tests
#    many modern R approaches have a method for dealing or specifying autocorrelated
#   errors - sometimes referred to as covariance in the errors.





# Stationarity: mathematically no moment of the distribution for the time series depends upon or changes predictably with time.
#               Practically, constant mean, variance, and autocovariance does not depend on time
# Can check to see if your data is 

adf.test(random)
adf.test(x, alternative = "stationary")
adf.test(NDVI.ts)
adf.test(PPT.ts)
adf.test(rats.ts)

# if p value > 0.05, the time series is not stationary
# if p value < 0.05, time series is stationary

adf.test(NDVI.ts)


