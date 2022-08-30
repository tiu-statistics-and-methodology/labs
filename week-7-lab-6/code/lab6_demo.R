### Title:    Stats & Methods Lab 6 Demonstration Script
### Author:   Kyle M. Lang, Edo
### Created:  2017-10-08
### Modified: 2022-03-18

# Set up ----------------------------------------------------------------------

# Install a few packages we need
install.packages(c("lmtest", "moments", "sandwich"),
                repos = "http://cloud.r-project.org")

# Clean environment
rm(list = ls(all = TRUE))

# Load the packages we need
library(MASS)     # For the 'Cars93' data
library(lmtest)   # Provides Breusch-Pagan and RESET Tests
library(moments)  # Provides skewness and kurtosis
library(sandwich) # Provided HC variance estimators

# Load some data:
data(Cars93)

# Topic 1 - Regression diagnostics ---------------------------------------------

# Fit a linear model of interest
out1 <- lm(Price ~ Horsepower + MPG.city + Passengers, data = Cars93)

# Look at the summary
summary(out1)

# Save the residuals and fitted values from out1:
res1  <- resid(out1)
yHat1 <- predict(out1)

# > Homoscedasticity ---------------------------------------------------------

# Visual check: residual plot

  # Residuals vs. Predicted plot
  plot(y = res1, x = yHat1)

  # Add an horizontal line as visual aid
  abline(h = 0, col = "gray")

# Test: Breusch-Pagan Test.

  # Run the Breusch-Pagan Test:
  bptest(out1)

# Consequences of assuming homoscedasticity (when we shouldn't)

  # Compute regular ACOV
  cov1 <- vcov(out1)

  # Identify the standard errors
  sqrt(diag(cov1))
  summary(out1)$coefficients

  # Compute Heteroscedasticity Consistent (HC) estimate of the ACOV
  covHC1 <- vcovHC(out1)

  # Perform robust t-tests for the coefficients
  coeftest(out1, vcov = covHC1)

# Use HC estimate of the covariance matrix for change in R2 test

  # Extend 'out1' by adding some interactions:
  out1.2 <- update(out1, ". ~ . + Horsepower * MPG.city + Passengers * MPG.city")
  summary(out1.2)

  # Compare the 'out1' and 'out1.2' models using robust SEs
  waldtest(out1, out1.2, vcov = vcovHC)

  # Equivalently
  covHC1.2 <- vcovHC(out1.2)
  waldtest(out1, out1.2, vcov = covHC1.2)

# > Normality of the residuals -------------------------------------------------

# Background info: understanding normality

  # How a normal distribution looks like
  plot(density(rnorm(10000)))

  # Create a kernel density plot of 'Price'
  plot(density(Cars93$Price))

  # Check skewness of 'Price'
  skewness(Cars93$Price)

  # What is the kurtosis of a normal distribution?
  kurtosis(rnorm(10000))

  # Check kurtosis of 'Horsepower'
  kurtosis(Cars93$Horsepower)

# Numerical check of normality of residuals

  # Skewness of the residuals from model out1
  skewness(res1)

  # Kurtosis of the residuals from model out1
  kurtosis(res1)

# Visual check of normality of residuals

  # Q-Q Plot
  qqnorm(res1)
  qqline(res1)

  # Alternative using plot.lm function
  plot(out1, which = 2)

# Test the normality of residuals via Shapiro-Wilk test and KS test:

  # Perform Shapiro-Wilk test
  shapiro.test(res1)

  # Perform Kolmogorov-Smirnov test
  ks.test(x = res1, y = pnorm, mean = mean(res1), sd = sd(res1))

# > Model (mis)specification ---------------------------------------------------

# Nonlinear trends in residual plots

  # Residual plot with local fit line (loess line)
  scatter.smooth(y     = res1,
                 x     = yHat1,
                 span  = 0.5,
                 lpars = list(col = "red")
                 )

  # Add horizontal line as visual aid
  abline(h = 0, col = "gray")

  # Alternative using plot.lm function
  plot(out1, which = 1)

  # Alternative using plot.lm function and standardized residuals
  plot(out1, which = 3)

# Functional form misspecification test

  # Consider a different model
  out2 <- lm(MPG.city ~ Horsepower + Fuel.tank.capacity + Weight, data = Cars93)
  summary(out2)

  # Visual: Nonlinear Trends in residual (vs. predicted) plot
  plot(out2, which = 1)

  # Test: Run the Ramsey RESET:
  resettest(out2)

# Investigate relationship with Horsepower is quadratic

  # Update the model
  out2.1 <- update(out2, ". ~ . + I(Horsepower^2)")
  summary(out2.1)

  # Visual: Nonlinear Trends in residual (vs. predicted) plot
  plot(out2.1, which = 1)

  # Perform resettest again
  resettest(out2.1)

# Investigate relationship with Weight is quadratic

  # Update the model
  out2.2 <- update(out2, ". ~ . + I(Weight^2)")
  summary(out2.2)

  # Visual: Nonlinear Trends in residual (vs. predicted) plot
  plot(out2.2, which = 1)

  # Residuals vs. Predicted plot:
  resettest(out2.2)

# Compare the other plots of interest between the out2 and out2.2

  par(mfrow = c(2, 1))

  # Residual plot
  plot(out2, which = 1)
  plot(out2.2, which = 1)

  # Q-Q Plot:
  plot(out2, which = 2)
  plot(out2.2, which = 2)

  # Scale-Location Plot:
  plot(out2, which = 3)
  plot(out2.2, which = 3)

  # Cook's Distance Plot:
  plot(out2, which = 4)
  plot(out2.2, which = 4)

  # Residuals vs. Leverage Plot:
  plot(out2, which = 5)
  plot(out2.2, which = 5)

  dev.off()

# Topic 2: Influential observations --------------------------------------------

# > Studentized residuals ------------------------------------------------------

  # Compute Externally studentized residuals
  sr2 <- rstudent(out2.2)
  sr2

  # Create index plot of studentized residuals:
  plot(sr2)

  # Find outliers
  badSr2 <- which(abs(sr2) > 3)
  badSr2

# > Leverages ------------------------------------------------------------------

  # Compute leverages
  lev2 <- hatvalues(out2.2)
  lev2

  # Create index plot of leverages:
  plot(lev2)

  # Identify high-leverage observations
  lev2.s <- sort(lev2, decreasing = TRUE)
  lev2.s

  # Store the observation numbers for the most extreme leverages:
  badLev2 <- as.numeric(names(lev2.s[1 : 3]))
  badLev2

  # Or select observations having a leverage higher than 0.2
  badLev2 <- which(lev2 > 0.2)
  badLev2

  # Residuals + Leverage Plot:
  plot(out2.2, which = 5)

# > Measures of influence ------------------------------------------------------

  # Compute a all of the influence measures
  im2 <- influence.measures(out2.2)
  im2

  # Compute difference in fits DFFITS (Global)
  dff2 <- dffits(out2.2)
  dff2

  # Compute Cook's Distance (Global)
  cd2  <- cooks.distance(out2.2)
  cd2

  # Compute differences in betas DFBETAS (coefficient specific)
  dfb2 <- dfbetas(out2.2)
  dfb2

  # Create index plots for measures of influence
  plot(dff2)
  plot(cd2)
  plot(out2.2, which = 4)

  plot(dfb2[ , 1])
  plot(dfb2[ , 2])
  plot(dfb2[ , 3])
  plot(dfb2[ , 4])
  plot(dfb2[ , 5])

  # Find the single most influential observation
  maxCd   <- which.max(cd2)
  maxDff  <- which.max(abs(dff2))
  maxCd
  maxDff

  # Find the single most influential observation on the intercept
  maxDfbI <- which.max(abs(dfb2[ , 1]))
  maxDfbI

  # Find the single most influential observation on quadratic term
  maxDfbQ <- which.max(abs(dfb2[ , 5]))
  maxDfbQ

# > Treating influential observations ------------------------------------------

# Treat outliers

  # Exclude the outliers
  Cars93.o <- Cars93[-badSr2, ]

  # Refit the quadratic model
  out2.2o <- update(out2.2, data = Cars93.o)

  # Compare the fits
  summary(out2.2)
  summary(out2.2o)

# Treat high-leverage observations

  # Exclude the high-leverage points:
  Cars93.l <- Cars93[-badLev2, ]

  # Refit the quadratic model:
  out2.2l <- update(out2.2, data = Cars93.l)

  # Compare the fits
  summary(out2.2)
  summary(out2.2l)

# Treat most influential observation

  # Exclude the most influential observation:
  Cars93.i <- Cars93[-maxCd, ]

  # Refit the quadratic model:
  out2.2i <- update(out2.2, data = Cars93.i)

  # Compare the fits
  summary(out2.2)
  summary(out2.2i)

  # Exclude the observation with greatest influence on the quadratic term
  Cars93.q <- Cars93[-maxDfbQ, ]

  # Refit the quadratic model:
  out2.2q <- update(out2.2, data = Cars93.q)

  # Compare fits
  summary(out2.2)
  summary(out2.2q)