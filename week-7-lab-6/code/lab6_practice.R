### Title:    Stats & Methods Lab 6 Practice Script
### Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
### Created:  2018-10-09
### Modified: 2022-03-14


###          ###
### Overview ###
###          ###

## You will practice regression diagnostics for MLR models.

## You will need the "airQual.rds" dataset which is available in the "data"
## directory for this lab.


###                   ###
### Tasks / Questions ###
###                   ###


##--Preliminaries-------------------------------------------------------------##

## 1) Use the "install.packages" function to install the "moments", "lmtest",
##    and "sandwich" packages.

## 2) Use the "library" function to load the "moments", "lmtest", and "sandwich"
##    packages.

## 3) Use the "readRDS" function to load the "airQual.rds" dataset into your
##    workspace.


##--Model specification-------------------------------------------------------##

### Use the "airQual" data to complete the following:

## 4) Regress "Temp" onto "Ozone", "Wind", and "Solar.R".

## 5a) Plot the residuals from the model estimated in (4) against its fitted
##     values.
## 5b) Add a loess line to the residual plot from (5a).
## 5c) What can you infer from the plots created in (5a) and (5b)?
## 5d) What do you think is the best course of action to correct the issues
##     represented in the plot from (5a)?

## 6a) Conduct a Ramsey RESET for the model estimated in (4).
##     -- Add the second and third powers of the fitted values.
## 6b) What do the results of the RESET in (6a) tell you?

## 7a) Update the model estimated in (4) three times. In each new model, add the
##     square of exactly one of the predictor variables.
##     -- Each of these three models should be identical to the model from (4)
##        except for the inclusion of a different quadratic term.
## 7b) For each of the updated models estimated in (7a) compute the same type of
##     residual plot that you created in (5a) and conduct a Ramsey RESET as you
##     did in (6a).
## 7c) Which predictor's quadratic term most improved the model specification?
## 7d) Does the RESET for the model you indicated in (7c) still suggest
##     significant misspecification?


##--Diagnostics---------------------------------------------------------------##

### Use the "airQual" data to complete the following:

## 8) Regress "Temp" onto "Ozone", "Wind", "Solar.R", and the square of "Ozone".
##    -- In the following sections, this model will be referred to as "M0".

## 9a) Plot the residuals from the model estimated in (8) against its fitted
##     values, and add a loess line to the plot.
## 9b) What can you infer from the plot created in (9a)?

## 10a) Conduct a Breusch-Pagan test for the model estimated in (8).
## 10b) What does the Breusch-Pagan test you conducted in (10a) tell you?
## 10c) Do the Breusch-Pagan test from (10a) and the residual plots from (9a) agree?

## 11a) Evaluate the normality of the residuals from the model in (8) using a Q-Q
##      plot, the skewness, the kurtosis, the Shapiro-Wilk test, and the
##      Kolmogorov-Smirnov test.
## 11b) Do the results of the diagnostics you conducted for (11a) agree?
## 11c) Create a kernel density plot of the residuals from the model in (8).
## 11d) Judging by the information gained in (11a) and (11b), do you think it's
##      safe to assume normally distributed errors for the model in (8)?


##--Robust SEs----------------------------------------------------------------##

### Use the "airQual" data to complete the following:

## 12) Estimate the heteroscedasticity consistent (HC) asymptotic covariance
##     matrix for M0 (i.e., the model from (8) in the "Diagnostics" section).

## 13a) Use the HC covariance matrix from (12) to test the coefficients of M0 with
##      robust SEs.
## 13b) Compare the results from (13a) to the default tests of M0's coefficients.
##      What changes when using robust SEs?

## 14) Update M0 by adding the squares of "Wind" and "Solar.R".

## 15a) Using HC estimates of the SEs, conduct a nested model comparison to test
##      if adding the squares of "Wind" and "Solar.R" to M0 explains
##      significantly more variance in "Temp".
## 15b) What is the conclusion of the test you conducted in (15a)?
## 15c) Compare the test in (15a) to the default version that does not use HC
##      estimates of the SEs. What differs when using robust SEs?


##--Influential observations--------------------------------------------------##

### Use the "airQual" data to complete the following:

## 16a) Compute the studentized residuals of M0 (i.e., the model from (8) in the
##      "Diagnostics" section).
## 16b) Create an index plot of the residuals computed in (16a).
## 16c) What can you infer from the plot in (16b)?
## 16d) What are the observation numbers for the two most probable outliers
##      according to the residuals from (16a)?

## 17a) Compute the leverages of M0.
## 17b) Create an index plot of the leverages computed in (17a).
## 17c) What can you infer from the plot in (17b)?
## 17d) What are the observation numbers with the three highest leverages?

## 18a) Compute the Cook's distances of M0.
## 18b) Create an index plot of the distances computed in (18a).
## 18c) What can you infer from the plot in (18b)?
## 18d) What are the observation numbers for the five most influential cases
##      according to the distances from (18a)?

## 19a) Compute the DFFITS of M0.
## 19b) Create an index plot of the DFFITS computed in (19a).
## 19c) What can you infer from the plot in (19b)?
## 19d) What are the observation numbers for the five most influential cases
##      according to the DFFITS from (19a)?
## 19e) Do the results from (19d) agree with the results from (18d)?
## 19e) What do you notice about the set of observations flagged as influential
##      cases in (19d) relative to the observations flagged as high leverage
##      points in (17d) and those flagged as outliers in (16d)?

## 20a) Remove the five most influential cases from (19d), and use the cleaned
##      data to rerun M0.
## 20b) Compare the results of the model in (20a) to the results of the original
##      M0. What changes when removing the influential cases?

##----------------------------------------------------------------------------##
