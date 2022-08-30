### Title:    Stats & Methods Lab 1 Practice Script
### Authors:  Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
### Created:  2018-04-10
### Modified: 2022-02-03


###          ###
### Overview ###
###          ###

## You will practice inferential testing, some basic EDA techniques, missing
## data descriptives, and outlier analysis.

## You will need four datasets to complete the following tasks: "bfi_clean.rds",
## "tests.rds", "bfiOE.rds", and "airQual.rds". These datasets are saved in the
## "data" directory for this set of lab materials.


###                   ###
### Tasks / Questions ###
###                   ###


##--Preliminaries-------------------------------------------------------------##

## 1) If you have not already done so, use the "install.packages" function to
##    install the "mice" package.

## 2) Use the "library" function to load the "mice" and "MASS" packages.

## 3) Use the "paste0" function and the "readRDS" function to load the four
##    datasets into memory.


##--Testing-------------------------------------------------------------------##

### Use the "bfi_clean" data to complete the following analyses/tasks:

## 4a) Conduct a t-test to check for gender differences in mean levels of
##     "agree" (i.e., agreeableness). Do not assume equal variances.
## 4b) What is the value of the estimated mean difference in "agree"?
## 4c) What is the value of the estimated t-statistic?
## 4d) Is the estimated mean difference significant at the alpha = 0.05 level?

## 5a) Conduct a t-test to check for gender differences in mean levels of
##     "agree" (i.e., agreeableness). Assume equal variances.
## 5b) What is the value of the estimated mean "agree" for males?
## 5c) What is the value of the estimated t-statistic?
## 5d) What is the 95% CI for the estimated mean difference?
## 5e) Is the t-statistic you found here different from the one you computed in
##     Q1? If so, why?

## 6a) Test for a significant Pearson correlation between "agree" and "neuro"
##    (i.e., neuroticism).
## 6b) What is the value of the correlation coefficient?
## 6c) Is this correlation significantly different from zero at the alpha = 0.05
##     level?

## 7a) Test the hypothesis that the correlation between "consc"
##     (i.e., conscientiousness) and "neuro" is less than zero.
## 7b) What is the value of the estimated correlation coefficient?
## 7c) What is the 95% CI for the estimated correlation coefficient?
## 7d) Is this correlation significantly less than zero at the alpha = 0.05
##     level?

##--EDA-----------------------------------------------------------------------##

### Use the "tests" data to answer the following questions:

## 8) What are the dimensions of these data?

## 9) What is the mean "SATQ" score?

## 10) What is the variance of the "SATQ" scores?

## 11) What is the median "SATV" score?

## 12) Create a histogram of the "ACT" variable.

## 13) Create a kernel density plot of the "ACT" variable.

## 14) Overlay a normal density on top of the "ACT" histogram.

## 15) Create a grouped boxplot that plots "ACT" by "education".

## 16) Create a frequency table of "education".

## 17) Create a contingency table that cross-classifies "gender" and
##     "education".

## 18) Suppose a certain university admits any student with an ACT score of, at
##     least, 25. How many of the women in the "tests" data would be admitted?


##--Missing Data Descriptives-------------------------------------------------##

### Use the "bfiOE" data to answer the following questions:

## 19a) Compute the proportion of missing values for each variable.
## 19b) What is the percentage of missing data for "O1"?

## 20a) Compute the number of observed values for each variable:
## 20b) What is the number of observed values for "E1"?

## 21a) Compute the covariance coverage matrix.
## 21b) What is the range of covariance coverage values?
## 21c) What is the covariance coverage between "E2" and "O4"?
## 21d) How many unique covariance coverages are less than 0.75?

## 22a) Compute the missing data patterns for these data.
## 22b) How many distinct missing data patterns exist in these data?
## 22c) How many missing data patterns have only one missing value?
## 22d) How many observations are affected by patterns that involve only one
##      missing value?


##--Outliers------------------------------------------------------------------##

### NOTE: You can use the functions provided in the demonstrations script to
###       complete the following tasks.

### Use the "airQual" data to complete the following:

## 23a) Use Tukey's boxplot method to find possible and probable outliers in the
##     "Ozone", "Solar.R", "Wind", and "Temp" variables.
## 23b) Did you find any possible outliers?
## 23c) Did you find any probable outliers?
## 23d) Which, if any, observations were possible outliers on "Ozone"?
## 23e) Which, if any, observations were probable outliers on "Wind"?

## 24a) Use the MAD method (with a cutoff of 3) to find potential outliers in
##     the "Ozone", "Solar.R", "Wind", and "Temp" variables.
## 24b) Did you find any potential outliers?
## 24c) Which, if any, observations are potential outliers on "Wind"?

### For Question 3, you will use different parameterizations of robust
### Mahalanobis distance (with MCD estimation) to check for multivariate
### outliers on the "Ozone", "Solar.R", "Wind", and "Temp" variables.

### NOTE: When running the mcdMahaonobis() function, set the seed to "235711".

## 25a) Which, if any, observations are flagged as multivariate outliers when
##     using 75% of the sample for the MCD estimation and using a probability of
##     0.99 for the cutoff value?
## 25b) Which, if any, observations are flagged as multivariate outliers when
##     using 75% of the sample for the MCD estimation and using a probability of
##     0.999 for the cutoff value?
## 25c) Which, if any, observations are flagged as multivariate outliers when
##     using 50% of the sample for the MCD estimation and using a probability of
##     0.99 for the cutoff value
## 25d) Which, if any, observations are flagged as multivariate outliers when
##     using 50% of the sample for the MCD estimation and using a probability of
##     0.999 for the cutoff value?
## 25e) Based on the above, what consequences do you observe when changing the
##     fraction of the sample used for MCD estimation and when changing the
##     cutoff probability?
