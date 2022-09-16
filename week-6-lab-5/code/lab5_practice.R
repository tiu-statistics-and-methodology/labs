### Title:    Stats & Methods Lab 5 Practice Script
### Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
### Created:  2018-09-24
### Modified: 2022-09-16


###          ###
### Overview ###
###          ###

## You will practice using MLR models for moderation analysis.

## You will need the "msq2.rds" data and the built-in R datasets "cps3" and
## "leafshape" (from the DAAG package). The "msq2.rds" dataset is available in
## the "data" directory for this lab.


###                   ###
### Tasks / Questions ###
###                   ###


##--Preliminaries-------------------------------------------------------------##

## 1) Use the "install.packages" function to install the "rockchalk" and "DAAG"
##    packages.

## 2) Use the "library" function to load the "rockchalk" and "DAAG" packages.

## 3) Use the "readRDS" function to load the "msq2.rds" dataset into your
##    workspace.

## 4) Use the "data" function to load the "cps3" and "leafshape" datasets into
##    your workspace.


##--Continuous Variable Moderation--------------------------------------------##

### Use the "msq2" data to complete the following:

## 5a) Estimate a model that tests if the effect of Energetic Arousal (EA) on
##     Tense Arousal (TA) varies as a function of Negative Affect (NegAff),
##     after controlling for Positive Affect (PA).
## 5b) What is the value of the parameter estimate that quantifies the effect of
##     Negative Affect on the Energetic Arousal -> Tense Arousal effect, after
##     controlling for Positive Affect?
## 5c) Does Negative Affect significantly moderate (at the alpha = 0.05 level)
##     the relationship between Energetic Arousal and Tense Arousal, after
##     controlling for Positive Affect?
## 5d) After controlling for Positive Affect, how does Negative Affect impact
##     the relationship between Energetic Arousal and Tense Arousal? Provide a
##     sentence interpreting the appropriate effect.

## 6a) Use the centering method to test the simple slopes of the model you
##     estimated in (5a) at Negative Affect values of 0, 10, and 20.
## 6b) After controlling for Positive Affect, what is the simple slope of
##     Energetic Arousal on Tense Arousal when Negative Affect is 0.
## 6c) Is the simple slope you estimated in (6b) statistically significant at
##     the alpha = 0.05 level?
## 6d) After controlling for Positive Affect, what is the simple slope of
##     Energetic Arousal on Tense Arousal when Negative Affect is 10.
## 6e) Is the simple slope you estimated in (6d) statistically significant at
##     the alpha = 0.05 level?
## 6f) After controlling for Positive Affect, what is the simple slope of
##     Energetic Arousal on Tense Arousal when Negative Affect is 20.
## 6g) Is the simple slope you estimated in (6f) statistically significant at
##     the alpha = 0.05 level?

## 7a) Use the 'rockchalk' package to test the same simple slopes you estimated
##     in (6a).
## 7b) Do the results of the centering approach agree with the results from
##     'rockchalk'?

## 8a) Use the 'rockchalk' package to implement a Johnson-Neyman analysis of the
##     interaction you estimated in (5a).
## 8b) What are the boundaries of the Johnson-Neyman region of significance?
## 8c) Where in the distribution of Negative Affect is the effect of Energetic
##     Arousal on Tense Arousal (controlling for Positive Affect) statistically
##     significant?


##--Binary Categorical Moderators---------------------------------------------##

### Use the "cps3" data to complete the following:

## 9a) Estimate a model that tests if the effect of Years of Education on Real
##     Earnings in 1975 is significantly moderated by being Hispanic, after
##     controlling for Real Earnings in 1974.
##     HINT: The Hispanic variable is not a factor. You may want to change that.
## 9b) After controlling for 1974 Earnings, does being Hispanic significantly
##     affect the relationship between Years of Education and 1975 Earnings at
##     the alpha = 0.05 level
## 9c) After controlling for 1974 Earnings, does being Hispanic significantly
##     affect the relationship between Years of Education and 1975 Earnings at
##     the alpha = 0.01 level?

## 10a) What is the simple slope of Years of Education on 1975 Earnings
##      (controlling for 1974 Earnings) for Non-Hispanic people?
## 10b) Is the simple slope from (10a) statistically significant at the
##      alpha = 0.05 level?
## 10c) What is the simple slope of Years of Education on 1975 Earnings
##      (controlling for 1974 Earnings) for Hispanic people?
##      Note: To obtain the result with more decimals you can always use 
##            the coef() function.
## 10d) Is the simple slope from (10c) statistically significant at the
##      alpha = 0.05 level?
## 10e) Visualize the simple slopes compute above in an appropriate way.


##--Nominal Categorical Moderators--------------------------------------------##

### Use the "leafshape" data to complete the following:

## 11a) What are the levels of the "location" factor?
## 11b) What are the group sizes for the "location" factor?

## 12a) Estimate a model that tests if the effect of Leaf Width on Leaf Length
##      differs significantly between Locations.
## 12b) Does the effect of Leaf Width on Leaf Length differ significantly
##      (alpha = 0.05) between Locations?
## 12c) What is the value of the test statistic that you used to answer (12b)?

## 13a) What is the simple slope of Leaf Width on Leaf Length in Sabah?
## 13b) Is the simple slope you reported in (13a) significant at the alpha = 0.05
##      level?
## 13c) What is the simple slope of Leaf Width on Leaf Length in Panama?
## 13d) Is the simple slope you reported in (13c) significant at the alpha = 0.05
##      level?
## 13e) What is the simple slope of Leaf Width on Leaf Length in South
##      Queensland?
## 13f) Is the simple slope you reported in (13e) significant at the alpha = 0.05
##      level?

## 14a) In which Location is the effect of Leaf Width on Leaf Length strongest?
## 14b) What caveat might you want to place on the conclusion reported in (14a)?
##      HINT: Look at the answers to Question 11.

##----------------------------------------------------------------------------##
