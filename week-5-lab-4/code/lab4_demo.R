### Title:    Stats & Methods Lab 4 Demonstration Script
### Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
### Created:  2017-09-08
### Modified: 2022-03-02

rm(list = ls(all = TRUE))

install.packages("wec", repos = "http://cloud.r-project.org")

library(wec)                 # For weighted effects codes
source("studentFunctions.R") # For summary.cellMeans()

## Load the iris data
data(iris)

set.seed(235711)

## Sample 100 rows to unbalance group sizes:
iris <- iris[sample(1 : nrow(iris), 100), ]

###--------------------------------------------------------------------------###

### Factor Variables ###

## Look at the 'Species' factor:
iris$Species
is.factor(iris$Species)

str(iris$Species)
summary(iris$Species)

## Factors have special attributes:
attributes(iris$Species)
attributes(iris$Petal.Length)
attributes(iris)

## Factors have labeled levels:
levels(iris$Species)
nlevels(iris$Species)

## Factors are not numeric variables:
mean(iris$Species)
var(iris$Species)
iris$Species - iris$Species

###--------------------------------------------------------------------------###

### Creating Factor Variables ###

# Create a variable with 10 values
x <- c(1, 1, 2, 1, 3, 1, 2, 3, 2, 1)

# Explore how x looks
x
class(x)
unique(x)

# Transform x (numeric atomic vector) into a factor
y <- factor(x, levels = c(1, 2, 3))

# Explore how y looks
y
class(y)
levels(y)

# We can forget to create a level we needed
y <- factor(x, levels = c(1, 2))
y

# We can create an empty factor level
y <- factor(x, levels = c(1, 2, 3, 4))
y
table(y)

# We can let R choose levels by default
y <- factor(x)
y

# Arithmetic doesn't work anymore!
mean(y)

# Transform x into a factor with meaningful labels:
z <- factor(x,
            levels = c(1, 2, 3),
            labels = c("setosa", "versicolor", "virginica"))
z
data.frame(x, z)

# Play around with the order of the levels
z2 <- factor(x,
             levels = c(2, 1, 3),
             labels = c("versicolor", "setosa", "virginica"))
z2
data.frame(x, z, z2)

# Check whether the two factors are the same or not
all.equal(z, z2)

# Check the levels: the order is different!
levels(z)
levels(z2)

###--------------------------------------------------------------------------###

### Dummy Codes ###

## Use a factor variable as a predictor:
out1 <- lm(Petal.Length ~ Species, data = iris)
summary(out1)

## Check the contrasts:
contrasts(iris$Species)

## Change the reference group:
iris$Species2 <- relevel(iris$Species, ref = "virginica")

levels(iris$Species)
levels(iris$Species2)

## How are the contrasts affected:
contrasts(iris$Species)
contrasts(iris$Species2)

## Which carries through to the models:
out2 <- lm(Petal.Length ~ Species2, data = iris)
summary(out1)
summary(out2)

###--------------------------------------------------------------------------###

### Cell-Means Codes ###

out3 <- lm(Petal.Length ~ Species - 1, data = iris)
summary(out3)
summary.cellMeans(out3)

###--------------------------------------------------------------------------###

### Unweighted Effects Codes ###

## Use the 'contr.sum' function to create unweighted effects-coded contrasts:
?contr.sum

iris$Species3            <- iris$Species
contrasts(iris$Species3) <- contr.sum(levels(iris$Species3))
contrasts(iris$Species3)

## Use the fancy-pants Species factor:
out4 <- lm(Petal.Length ~ Species3, data = iris)
summary(out4)
contrasts(iris$Species3)

## How about some better names?
colnames(contrasts(iris$Species3)) <- c("setosa", "versicolor")
contrasts(iris$Species3)

out5 <- lm(Petal.Length ~ Species3, data = iris)
summary(out5)

## Change the omitted group:
iris$Species4 <- iris$Species
levels(iris$Species4)
iris$Species4 <- relevel(iris$Species4, ref = "virginica")

levels(iris$Species)
levels(iris$Species4)

## This won't work:
tmp <- relevel(iris$Species, ref = "versicolor")

levels(iris$Species)
levels(tmp)

## Define a function to automatically change the omitted group:
changeOmitted <- function(x) relevel(x, ref = levels(x)[nlevels(x)])

tmp <- changeOmitted(iris$Species)

levels(iris$Species)
levels(tmp)

## Update the contrasts attribute:
contrasts(iris$Species4)
contrasts(iris$Species4) <- contr.sum(nlevels(iris$Species4))
contrasts(iris$Species4)

## Give some good names:
colnames(contrasts(iris$Species4)) <- c("virginica", "setosa")
contrasts(iris$Species4)

## Use the new factor:
out6 <- lm(Petal.Length ~ Species4, data = iris)
summary(out5)
summary(out6)

## To summarize:
iris$Species4            <- iris$Species
iris$Species4            <- changeOmitted(iris$Species4) # change omitted category
contrasts(iris$Species4) <- contr.sum(nlevels(iris$Species4)) # create constrasts
colnames(contrasts(iris$Species4)) <- c("virginica", "setosa") # fix names

contrasts(iris$Species)
contrasts(iris$Species3)
contrasts(iris$Species4)

###--------------------------------------------------------------------------###

### Weighted Effects Codes ###

## Use the 'contr.wec' function to create weighted effects-coded contrasts:
iris$Species5            <- iris$Species
contrasts(iris$Species5) <- contr.wec(iris$Species, omitted = "virginica")
contrasts(iris$Species5)

out7 <- lm(Petal.Length ~ Species5, data = iris)
summary(out7)

## Create contrast with a different reference level:
iris$Species6            <- iris$Species
contrasts(iris$Species6) <- contr.wec(iris$Species, omitted = "setosa")
contrasts(iris$Species6)

out8 <- lm(Petal.Length ~ Species6, data = iris)
summary(out8)
summary(out7)

###--------------------------------------------------------------------------###

### Reverting to Default "Treatment" Contrasts ###

tmp <- iris$Species6
contrasts(tmp)

## Dummy codes without names:
contrasts(tmp) <- contr.treatment(nlevels(tmp))
contrasts(tmp)

## Named dummy codes (default):
tmp            <- iris$Species6
contrasts(tmp) <- contr.treatment(levels(tmp))
contrasts(tmp)
contrasts(iris$Species)

###--------------------------------------------------------------------------###

### Testing the Effects of Grouping Factors ###

summary(out1)

## Test the effect of Species:
out0 <- lm(Petal.Length ~ 1, data = iris)
summary(out0)
anova(out0, out1)

## Test the partial effect of Species:
out9.1 <- lm(Petal.Length ~ Petal.Width, data = iris)
out9.2 <- update(out9.1, ". ~ . + Species")

summary(out9.1)
summary(out9.2)

anova(out9.1, out9.2)