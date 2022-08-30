### Title:    Stats & Methods Lab 4 Practice Script
### Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
### Created:  2018-09-24
### Modified: 2022-03-11


###          ###
### Overview ###
###          ###

## You will practice fitting MLR models with categorical predictor variables.

## You will need the built-in R datasets "bfi" (from the psych package) and
## "BMI" (from the wec) package.


###                   ###
### Tasks / Questions ###
###                   ###


##--Preliminaries-------------------------------------------------------------##

## 1) Use the "install.packages" function to install the "wec" and "psych"
##    packages.

## 2) Use the "library" function to load the "psych" and "wec" packages.

## 3) Use the "data" function to load the "bfi" and "BMI" datasets into your
##    workspace.

## 4) Source the "studentFunctions.R" file to initialize the summary.cellMeans()
##    function.


##--Factors-------------------------------------------------------------------##

### Use the "bfi" data to complete the following:
### -- You may ignore any missing data, for the purposes of these exercises
###    (although you should never do so in a real data analysis).

## 5) Refer to the help file of the "bfi" dataset to find the correct levels for
##    the "gender" and "education" variables.

## 6) Create factors for the "gender" and "education" variables with sensible
##    sets of labels for the levels.

## 7) How many women in this sample have graduate degrees?


##--Dummy Codes---------------------------------------------------------------##

### Use the "BMI" data to complete the following:

## 8) How many levels does the "education" factor have?

## 9a) What is the reference level of the "sex" factor?
## 9b) What is the reference level of the "education" factor?

## 10a) Run a linear regression model wherein "BMI" is predicted by dummy-coded
##     "sex" and "education".
##     -- Set the reference group to "male" for the "sex" factor
##     -- Set the reference group to "highest" for the "education" factor
## 10b) Is there a significant effect (at alpha = 0.05) of "sex" on "BMI" after
##     controlling for "education"?
## 10c) Based on the parameter estimates from (10a): What is the expected BMI for 
##     males in the highest education group?


##--Cell-Means Codes----------------------------------------------------------##

### Use the "BMI" data to complete the following:

## 11) Create a new variable by centering "BMI" on 25.

## 12a) Regress the centered BMI from (11) onto the set of cell-means codes for
##     "education".
## 12b) Is there a significant effect of education on BMI, at the alpha = 0.05
##     level?
## 12c) What is the value of the test statistic that you used to answer (12b)?
## 12d) Is the mean BMI level in the "lowest" education group significantly
##     different from 25, at an alpha = 0.05 level?
## 12e) Is the mean BMI level in the "middle" education group significantly
##     different from 25, at an alpha = 0.05 level?
## 12f) Is the mean BMI level in the "highest" education group significantly
##     different from 25, at an alpha = 0.05 level?


##--Unweighted Effects Codes--------------------------------------------------##

### Use the "BMI" data to complete the following:

## 13) Regress "BMI" onto an unweighted effects-coded representation of
##    "education" and a dummy-coded representation of "childless".
##    -- Adjust the contrasts attribute of the "education" factor to implement
##       the unweighted effects coding.

## 14) Change the reference group (i.e., the omitted group) for the unweighted
##    effects codes that you implemented in (13) and rerun the model regressing
##    "BMI" onto "education" and "childless".

## 15a) What is the expected BMI (averaged across education groups) for people
##     with children?
## 15b) Based on the parameter estimates from (14): What is the expected 
##     difference in BMI between the most highly educated group and the average 
##     BMI across education groups, after controlling for childlessness?
## 15c) Is the difference you reported in (15b) significantly different from zero,
##     at the alpha = 0.05 level?
## 15d) Based on the parameter estimates from (14): What is the expected 
##     difference in BMI between the middle education group and the average BMI 
##     across education groups, after controlling for childlessness?
## 15e) Is the difference you reported in (15d) significantly different from zero,
##     at the alpha = 0.05 level?


##--Weighted Effects Codes----------------------------------------------------##

### Use the "BMI" data to complete the following:

## 16) Regress "BMI" onto a weighted effects-coded representation of "education"
##    and a dummy-coded representation of "sex".
##    -- Adjust the contrasts attribute of the "education" factor to implement
##       the weighted effects coding.

## 17) Change the reference group (i.e., the omitted group) for the weighted
##    effects codes that you implemented in (16) and rerun the model regressing
##    "BMI" onto "education" and "sex".

## 18a) What is the expected difference in BMI between the least educated group
##     and the average BMI, after controlling for sex?
## 18b) Is the difference you reported in (18a) significantly different from zero,
##     at the alpha = 0.01 level?
## 18c) What is the expected difference in BMI between the most highly educated
##     group and the average BMI, after controlling for sex?
## 18d) Is the difference you reported in (18c) significantly different from zero,
##     at the alpha = 0.01 level?

## 19a) Does education level explain a significant proportion of variance in BMI,
##     above and beyond sex?
## 19b) What is the value of the test statistic that you used to answer (19a)?

##----------------------------------------------------------------------------##
