# Lecture:  04slr.pdf
# Topic:    Simple linear regression in R
# Author:   Edoardo Costantini
# Created:  2022-09-13
# Modified: 2022-09-13

# Define variables
y <- mtcars$mpg   # dependent variable
x <- mtcars$cyl   # single predictor
n <- nrow(mtcars) # sample size

# Fit simple linear model
lmfit <- lm(y ~ x)

# Extract estimated coefficients
summary(lmfit)$coefficients
b0_hat <- summary(lmfit)$coefficients["(Intercept)", "Estimate"]
b1_hat <- summary(lmfit)$coefficients["x", "Estimate"]

# calculate the standard errors -----------------------------------------------

# Calculate fitted values
y_hat <- fitted(lmfit)  # R function 1
y_hat <- predict(lmfit) # R function 2
y_hat <- b0_hat + b1_hat * x # by hand

# Calculate sigma_hat
s_hat <- sigma(lmfit) # R function
s_hat <- sqrt(sum((y - y_hat)^2) / (n - 2)) # by hand

# Calculate standard errors
b0_hat_se <- sqrt(s_hat^2 * (1 / n + mean(x)^2 / sum((x - mean(x))^2))) # SE of b0 (intercept)
b1_hat_se <- s_hat / sqrt(sum((x - mean(x))^2)) # se of b1

# Compare results
summary(lmfit)$coefficients # returned by R

data.frame(
    Estimate = c(b0 = b0_hat, b1 = b1_hat),
    SE = c(b0 = b0_hat_se, b1 = b1_hat_se)
)

# Confidence intervals --------------------------------------------------------

# Compute the precise critical value
tcrit <- abs(qt(p = (1 - .95) / 2, df = n - 2))

# Compute confidence intervals for b0 and b1
b0_hat_ci <- sort(c(
    b0_hat + tcrit * b0_hat_se,
    b0_hat - tcrit * b0_hat_se
))

b1_hat_ci <- sort(c(
    b1_hat + tcrit * b1_hat_se,
    b1_hat - tcrit * b1_hat_se
))

# Compare with R confidence intervals
rbind(
    b0_hat_ci,
    b1_hat_ci
)
confint(lmfit)
