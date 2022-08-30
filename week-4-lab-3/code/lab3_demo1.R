### Title:    Stats & Methods Lab 3 Demonstration Script 1
### Author:   Kyle M. Lang
### Created:  2017-09-08
### Modified by L.V.D.E. Vogelsmeier: 2021-09-13

###--------------------------------------------------------------------------###

### Preliminaries ###

rm(list = ls(all = TRUE)) # Clear workspace
setwd("") # Let's all set our working directory to the correct place

## Source the "studentFunctions.R" script to get the cv.lm function:
source("studentFunctions.R")

set.seed(235711) # Set the random number seed

library(MLmetrics) # We'll need this for MSEs

###--------------------------------------------------------------------------###

### Data I/O ###

dataDir <- "../data/"
ins     <- read.csv(paste0(dataDir, "insurance.csv")) 

###--------------------------------------------------------------------------###

### Prediction & Simple Split-Sample Cross-Validation ###

## Split the data into training and testing sets:
ind <- sample(
  c(rep("train", 1000),
    rep("test", nrow(ins) - 1000)
  )
)

ins_ss <- split(ins, ind)

## Estimate three models:
out1 <- lm(charges ~ age + sex, data = ins_ss$train)
out2 <- update(out1, ". ~ . + region + children")
out3 <- update(out2, ". ~ . + bmi + smoker")

### Or, first extract the data from the list: ###

train <- ins_ss$train
test <-  ins_ss$test

out1 <- lm(charges ~ age + sex, data = train)
out2 <- update(out1, ". ~ . + region + children")
out3 <- update(out2, ". ~ . + bmi + smoker")


## Check that everything worked:
summary(out1)
summary(out2)
summary(out3)

## Generate training-set predictions (i.e., y-hats):
p1 <- predict(out1)
p2 <- predict(out2)
p3 <- predict(out3)

## Generate training-set MSEs:
MSE(y_pred = p1, y_true = ins_ss$train$charges)
MSE(y_pred = p2, y_true = ins_ss$train$charges)
MSE(y_pred = p3, y_true = ins_ss$train$charges)

## Generate test-set predictions:
p1.2 <- predict(out1, newdata = ins_ss$test)
p2.2 <- predict(out2, newdata = ins_ss$test)
p3.2 <- predict(out3, newdata = ins_ss$test)

## Generate test-set MSEs:
MSE(y_pred = p1.2, y_true = ins_ss$test$charges)
MSE(y_pred = p2.2, y_true = ins_ss$test$charges)
MSE(y_pred = p3.2, y_true = ins_ss$test$charges)

## Get confidence and prediction intervals:
p3.3 <- predict(out3, newdata = ins_ss$test, interval = "confidence")
p3.4 <- predict(out3, newdata = ins_ss$test, interval = "prediction")

head(p3.3)
head(p3.4)

###--------------------------------------------------------------------------###

### Three-Way Split ###

## Split the sample into training, validation, and testing sets:
ind <- sample(
  c(rep("train", 800),
    rep("valid", 200),
    rep("test", nrow(ins) - 1000)
  )
)

table(ind)

ins_3w <- split(ins, ind)
class(ins_3w)
ls(ins_3w)

## Fit four competing models:
out0 <- lm(charges ~ age + sex, data = ins_3w$train)
out1 <- update(out0, ". ~ . + children")
out2 <- update(out0, ". ~ . + region")
out3 <- update(out0, ". ~ . + bmi")
out4 <- update(out0, ". ~ . + smoker")

## Estimate validation-set MSEs for each model:
mse1 <- MSE(y_pred = predict(out1, newdata = ins_3w$valid),
            y_true = ins_3w$valid$charges)
mse2 <- MSE(y_pred = predict(out2, newdata = ins_3w$valid),
            y_true = ins_3w$valid$charges)
mse3 <- MSE(y_pred = predict(out3, newdata = ins_3w$valid),
            y_true = ins_3w$valid$charges)
mse4 <- MSE(y_pred = predict(out4, newdata = ins_3w$valid),
            y_true = ins_3w$valid$charges)

mse <- c(mse1, mse2, mse3, mse4)

## Find the smallest validation-set MSE:
mse
min(mse)
which.min(mse)

## Re-estimate the chosen model using the pooled training and validation data:
out4.2 <- update(out4, data = rbind(ins_3w$train, ins_3w$valid))
summary(out4.2)

## Estimate prediction error using the testing data:
MSE(y_pred = predict(out4.2, newdata = ins_3w$test), y_true = ins_3w$test$charges)

###--------------------------------------------------------------------------###

### K-Fold Cross-Validation ###

### Manually implement K-fold cross-validation

## Define some useful constants:
K <- 10
N <- nrow(ins)

## Create a vector of candidate models:
models <- c("charges ~ age + sex + children",
            "charges ~ age + sex + region",
            "charges ~ age + sex + bmi",
            "charges ~ age + sex + smoker")

## Create a partition vector:
part <- sample(rep(1 : K, ceiling(N / K)))[1 : N]

## Set indices for demo purposes:
m <- 1
k <- 1

## Loop over candidate models:
cve <- c()
for(m in 1 : length(models)) {
  ## Loop over K repititions:
  mse <- c()
  for(k in 1 : K) {
    ## Partition data:
    dat0 <- ins[part != k, ]
    dat1 <- ins[part == k, ]
    
    ## Fit model and generate predictions:
    fit  <- lm(models[m], data = dat0)
    pred <- predict(fit, newdata = dat1)
    
    ## Save MSE:
    mse[k] <- MSE(y_pred = pred, y_true = dat1$charges)
  }
  ## Save the CVE:
  cve[m] <- mean(mse) 
}

## Examine cross-validation errors:
cve
which.min(cve)

### Use the "cv.lm" function to do K-fold cross-validation

## Compare the four models from above using 10-fold cross-validation:
cve2 <- cv.lm(data   = ins,
              models = c("charges ~ age + sex + children",
                         "charges ~ age + sex + region",
                         "charges ~ age + sex + bmi",
                         "charges ~ age + sex + smoker"),
              K      = 10,
              seed   = 235711)

cve2
cve2[which.min(cve2)]