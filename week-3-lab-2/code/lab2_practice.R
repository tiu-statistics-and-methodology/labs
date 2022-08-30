### Title:    Stats & Methods Lab 2 Practice Script
### Author:   Kyle M. Lang, L.V.D.E.Vogelsmeier, Edo
### Created:  2018-04-10
### Modified: 2022-02-15


###          ###
### Overview ###
###          ###

## You will practice basic regression modeling and model comparison.

## You will need the "longley.rds" dataset. This dataset is available in the
## "data" directory for this lab.

## IMPORTANT NOTE:
## You have to load the data from the folder as indicated here. R has a "longley" 
## dataset as well but, if you use this, it will lead to different results because 
## it differs a bit from the one in the folder. As it is a build-in dataset, 
## the function lm(GNP ~ Year, data = longley) would even work without loading the 
## build-in data. If you use the wrong dataset and obtain wrong results, you will 
## not get back lost points for corresponding questions in Quiz 3. Thus, please 
## make sure to load the data from the folder and use it for all analyses.


###                   ###
### Tasks / Questions ###
###                   ###


##--Preliminaries-------------------------------------------------------------##

## 1) Use the "install.packages" function to install the "MLmetrics" package.

## 2) Use the "library" function to load the "MLmetrics" packages.

## 3) Use the "paste0" function and the "readRDS" function to load the
##    "longley.rds" data into your workspace.


##--Linear Regression---------------------------------------------------------##

### Use the "longley" data for the following:

## 4a) Regress "GNP" onto "Year".
## 4b) What is the effect of "Year" on "GNP"?
## 4c) Is the effect of "Year" on "GNP" statistically significant at the
##     alpha = 0.05 level?
## 4d) Is the effect of "Year" on "GNP" statistically significant at the
##     alpha = 0.01 level?

## 5a) Regress "GNP" onto "Year" and "Population".
## 5b) Is there a significant effect (at the alpha = 0.05 level) of "Year" on
##     "GNP", after controlling for "Population"? 
## 5c) Is there a significant effect (at the alpha = 0.01 level) of "Year" on
##     "GNP", after controlling for "Population"? 
## 5d) What is the 95% confidence interval (CI) for the partial effect of
##     "Population" on "GNP"?

## 6a) Regress "GNP" onto "Year" and "Employed".
## 6b) What is the partial effect of "Employed" on "GNP", after controlling for
##     "Year"? 
## 6c) Is the partial effect of "Employed" on "GNP" statistically significant at
##     the alpha = 0.05 level?
## 6d) What is the 99% confidence interval (CI) for the partial effect of
##     "Employed" on "GNP"?

## 7a) Regress "GNP" onto "Year" and "Unemployed".
## 7b) What is the partial effect of "Unemployed" on "GNP", after controlling
##     for "Year"? 
## 7c) Is the partial effect of "Unemployed" on "GNP" statistically significant
##     at the alpha = 0.05 level?


##--Model Comparison----------------------------------------------------------##

### Use the "longley" data for the following:

## 8a) What is the difference in R-squared between the simple linear regression
##     of "GNP" onto "Year" and the multiple linear regression of "GNP" onto
##     "Year" and "Population"?
## 8b) Is this increase in R-squared significantly different from zero at the
##     alpha = 0.05 level? 
## 8c) What is the value of the test statistic that you used to answer (8b)?

## 9a) What is the MSE for the model that regresses "GNP" onto "Year" and
##     "Employed"?
## 9b) What is the MSE for the model that regresses "GNP" onto "Year" and
##     "Unemployed"?
## 9c) According to the MSE values calculated above, is "Employed" or
##     "Unemployed" the better predictor of "GNP"?
## 9d) Could we do the comparison in (9c) using an F-test for the difference in
##     R-squared values? Why or why not?
