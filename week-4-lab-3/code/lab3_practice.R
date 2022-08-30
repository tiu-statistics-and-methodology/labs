### Title:    Stats & Methods Lab 3 Practice Script
### Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
### Created:  2018-04-10
### Modified: 2022-02-25


###          ###
### Overview ###
###          ###

## You will practice prediction, cross-validation, and multiple imputation.

## You will need the "yps.rds" and "bfiANC2.rds" datasets to answer the
## following questions. These datasets are available in the "data" directory for
## this lab.


###                   ###
### Tasks / Questions ###
###                   ###


##--Preliminaries-------------------------------------------------------------##

## 1) Use the "library" function to load the "MLmetrics" and "mice" packages.

library(MLmetrics)
library(mice)

## 2) Use the "source" function to source the "studentFunctions.R" script.

source("studentFunctions.R")

## 3) Use the "paste0" function and the "readRDS" function to load the "yps.rds"
##    and "bfiANC2.rds" datasets into your workspace.

dataDir <- "../data/"
bfiANC2     <- readRDS(paste0(dataDir, "bfiANC2.rds"))
yps     <- readRDS(paste0(dataDir, "yps.rds"))

##--Prediction/Split-Sample Cross-Validation----------------------------------##

### Use the "yps" data to complete the following:

## 4) Randomly split the sample into disjoint training and testing sets with
##    sample sizes of N = 800 and N = 210, respectively.

set.seed(235711) # Set the random number seed

ind   <- sample(c(rep("train", 800), rep("test", 210)))
tmp   <- split(yps, ind)
train <- tmp$train
test  <- tmp$test

## 5a) Use the training data to estimate a baseline model that regresses
##     "Number.of.friends" onto "Age" and "Gender".
## 5b) Update the baseline model (from 5a) by adding "Keeping.promises",
##     "Empathy", "Friends.versus.money", and "Charity" as additional
##     predictors.
## 5c) Update the baseline model (from 5a) by adding "Branded.clothing",
##     "Entertainment.spending", "Spending.on.looks", and "Spending.on.gadgets"
##     as additional predictors.
## 5d) Update the baseline model (from 5a) by adding "Workaholism",
##     "Reliability", "Responding.to.a.serious.letter", and "Assertiveness" as
##     additional predictors.

## 6a) Compute training-set predictions from the three models you estimated in
##     (5b), (5c), and (5d).
## 6b) Compute training-set MSEs for the three models you estimated in (5b),
##     (5c), and (5d).
## 6c) Compute test-set predictions from the three models you estimated in (5b),
##     (5c), and (5d).
## 6d) Compute test-set MSEs for the three models you estimated in (5b), (5c),
##     and (5d).
## 6e) When comparing the models you estimated in (5b), (5c), and (5d) based on
##     their relative training-set prediction errors, which model should be
##     preferred?
## 6f) When comparing the models you estimated in (5b), (5c), and (5d) based on
##     their relative test-set prediction errors, which model should be
##     preferred?

## 7) Randomly split the sample into disjoint training, validation, and testing
##    sets with sample sizes of N = 700, N = 155, and N = 155, respectively.

set.seed(235711) # Set the random number seed

ind   <- sample(c(rep("train", 700), rep("valid", 155), rep("test", 155)))
yps2  <- split(yps, ind)
train <- yps2$train
valid <- yps2$valid
test  <- yps2$test

## 8a) Use the training data from (7) to re-estimate the model from (5b).
## 8b) Use the training data from (7) to re-estimate the model from (5c).
## 8c) Use the training data from (7) to re-estimate the model from (5d).

## 9a) Compute the validation-set predictions from the three models you
##     estimated in (8a), (8b), and (8c).
## 9b) Compute the validation-set MSEs for the three models you estimated in
##     (8a), (8b), and (8c).
## 9c) When comparing the models you estimated in (8a), (8b), and (8c) based on
##     their relative prediction errors, which model should be preferred?

## 10a) Re-estimate the chosen model in (9c) using the combined training and
##     validation data.

## 10b) Use the testing data that you set aside in (7) to estimate the prediction
##     error (i.e., test set MSE) of the updated model chosen in (10a).


##--Prediction/K-Fold Cross-Validation----------------------------------------##

### Use the "yps" data to complete the following:

## 11) Randomly split the sample into disjoint training and testing sets with
##    sample sizes of N = 800 and N = 210, respectively.

set.seed(235711) # Set the random number seed

index <- sample(c(rep("train", 800), rep("test", 210)))
yps2  <- split(yps, index)

## 12) Use the training data from (11) to run 5-fold cross-validation comparing
##    the following three models:
##    -- A model regressing "Number.of.friends" onto "Age" and "Gender",
##       "Keeping.promises", "Empathy", "Friends.versus.money", and "Charity".
##    -- A model regressing "Number.of.friends" onto "Age" and "Gender",
##       "Branded.clothing", "Entertainment.spending", "Spending.on.looks", and
##       "Spending.on.gadgets".
##    -- A model regressing "Number.of.friends" onto "Age" and "Gender",
##       "Workaholism", "Reliability", "Responding.to.a.serious.letter", and
##       "Assertiveness".

models <- c("Number.of.friends ~ Age + Gender + Keeping.promises + Empathy + Friends.versus.money + Charity",
            "Number.of.friends ~ Age + Gender + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets",
            "Number.of.friends ~ Age + Gender + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness")

### Perform the cross-validation with the cv.lm() function using "seed = 235711" inside the function:


## 13a) When comparing the models you tested in (12) based on their relative
##     cross-validation errors, which model should be preferred?

## 13b) Use the testing data that you set aside in (11) to estimate the prediction
##     error (i.e., test set MSE) of the model chosen in (13a).


##--Multiple Imputation-------------------------------------------------------##

### Use the "bfiANC2" data for the following:

## 14) Use the "mice" package, with the following setup, to create multiple
##    imputations of the "bfiANC2" data.
##    -- 25 imputations
##    -- 15 iterations
##    -- A random number seed of "314159"
##    -- All "A" variables imputed with predictive mean matching
##    -- All "C" variables imputed with linear regression using bootstrapping
##    -- All "N" variables imputed with Bayesian linear regression
##    -- The "education" variable imputed with polytomous logistic regression
##    -- A predictor matrix generated with the "quickpred" function using the
##       following setup:
##    ---- The minimum correlation set to 0.25
##    ---- The "age" and "gender" variables included in all elementary
##         imputation models
##    ---- The "id" variable excluded from all elementary imputation models
##
##    Tip 1: starts with defining your own method vector (e.g., "meth") and the 
##    predictor matrix (e.g., "predMat").
##    Tip 2: use the helpfunctions ?mice and ?quickpred to read more about the
##    arguments (e.g., the built-in imputation methods).

## 15a) Create traceplots of the imputed values' means and SDs to check that the
##     imputation models converged.
## 15b) Create overlaid density plots of the imputed vs. observed values to
##     sanity-check the imputaitons.
## 15c) Based on the plots you created in (15a) and (15b), would you say that the
##     imputations are valid?

## 16a) Use the "lm.mids" function to regress "A1" onto "C1", "N1", and
##     "education" using the multiply imputed data from (14)
## 16b) Use the "lm.mids" function to regress "A1" onto "C1", "N1", "education",
##     "age", and "gender" using the multiply imputed data from (14)

## 17a) What is the MI estimate of the slope of "age" on "A1" from (16b)?
## 17b) Is the effect in (17a) significant at the alpha = 0.05 level?

## 18a) What is the MI estimate of the R^2 from the model in (16a)?
## 18b) What is the MI estimate of the R^2 from the model in (16b)?

## 19a) What is the MI estimate of the increase in R^2 when going from the model
##     in (16a) to the model in (16b)?
## 19b) Is the increase in R^2 from (19a) statistically significant at the
##     alpha = 0.05 level?
## 19c) What is the value of the test statistic that you used to answer (19b)?
