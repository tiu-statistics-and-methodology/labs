# Project:   stats-meth
# Objective: Normality
# Author:    Edoardo Costantini
# Created:   2022-10-12
# Modified:  2022-10-12
# Notes: 

# Setup -----------------------------------------------------------------------

# Load packages
library(moments)
library(fBasics)

# Generate some skewed data
n <- 1e3
x <- rbeta(n, 5, 2)

# Ad for comparison generate one that is normal
z <- rnorm(n)

# Look at the plot
hist(x, freq = FALSE)
lines(density(x))

# Skewness -------------------------------------------------------------------- 

# Compute skewness by breaking the formula down
numerator <- sum((x - mean(x))^3) / n # mean as expected value
denominat <- sqrt((var(x) * (n - 1) / (n)))^3

# Compare
c(
    skew_moments = skewness(x),
    skew_manual = numerator / denominat
)

# Kurtosis --------------------------------------------------------------------

numerator <- sum((x - mean(x))^4) / n # mean as expected value
denominat <- (var(x) * (n-1) / (n))^2

# Compare
c(
    kurt_moments = kurtosis(x),
    kurt_manual = numerator / denominat
)

# QQplots ---------------------------------------------------------------------

# Refresh what quantiles are
cbind(
    theo_norm = qnorm(seq(0, 1, length.out = 10)),
    observed = quantile(x, probs = seq(0, 1, length.out = 10))
)

# Create QQ plot manually
plot(
    y = quantile(x, probs = seq(0, 1, length.out = 1e3)),
    x = qnorm(seq(0, 1, length.out = 1e3)),
    xlim = c(-3, 3)
)

# Non normal variable
qqnorm(x, xlim = c(-3, 3))
qqline(x)

# Normal variable
qqnorm(z)
qqline(z)

# Tests -----------------------------------------------------------------------

# Perform Shapiro-Wilk test
shapiro.test(x) # non-normal
shapiro.test(z) # normal

# Perform Kolmogorov-Smirnov test
ks.test(x = x, y = pnorm, mean = mean(x), sd = sd(x)) # non-normal
ks.test(x = z, y = pnorm, mean = mean(z), sd = sd(z)) # normal
