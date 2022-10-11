# Project:   stats-meth
# Objective: Exploring heteroschedastic consistent estimates
# Author:    Edoardo Costantini
# Created:   2022-10-11
# Modified:  2022-10-11
# Notes:     refer to macKinnonWhite:1985 Some heteroskedasticity-consistent covariance matrix estimators

# Fit some model
lmfit <- lm(mpg ~ ., mtcars)

# Extract the number of observations
n <- nobs(lmfit)

# Extract the number of estimated parameters (except intercept)
p <- length(lmfit$coefficients) - 1

# Define dependent variable
y <- mtcars[, 1]

# Define desing matrix for model
X <- cbind(1, as.matrix(mtcars[, -1]))

# Copmute hat matrix
Hmat <- X %*% solve(t(X) %*% X) %*% t(X)

# Compute residuals (aka u_hat)
cbind(
    lm = resid(lmfit),
    Hmat = drop((diag(1, n) - Hmat) %*% y)
)
u_hat <- resid(lmfit)

# Compute error variance estiamte (aka Sigma^2)
c(
    lm = sigma(lmfit)^2,
    resid = (sum(resid(lmfit)^2)) / (n - p - 1),
    Hmat = t(u_hat) %*% u_hat / (n - p - 1)
)
sigma2 <- sigma(lmfit)^2

# Compute standard variance-covariance matrix
vcov_mat <- sigma2 * solve(t(X) %*% X)
round(vcov_mat - vcov(lmfit), 5)

# Compute hetheroskedastic variance-covariance matrix
# Hetheroskedastic version
Omega <- diag(u_hat^2)

# HC
vcov_mat_HC <-  solve(t(X) %*% X) %*% t(X) %*% Omega %*% X %*% solve(t(X) %*% X)

# HC1
vcov_mat_HC_df <- n / (n - p - 1) * solve(t(X) %*% X) %*% t(X) %*% Omega %*% X %*% solve(t(X) %*% X)

# Compare sntadard errors obtained with each
cbind(
    HC1 = sqrt(diag(vcovHC(lmfit, type = "HC"))),
    HC1 = sqrt(diag(vcov_mat_HC)),
    HC2 = sqrt(diag(vcovHC(lmfit, type = "HC1"))),
    HC2 = sqrt(diag(vcov_mat_HC_df))
)

# HC becomes simple covariance matrix when homoschedasticity is there
Omega_standard <- diag(sigma2, n)
vcov_mat_HC_st <- solve(t(X) %*% X) %*% t(X) %*% Omega_standard %*% X %*% solve(t(X) %*% X)

cbind(
    st = sqrt(diag(vcov_mat)),
    st = sqrt(diag(vcov_mat_HC_st))
)
