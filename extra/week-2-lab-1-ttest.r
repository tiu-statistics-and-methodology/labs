# Lecture:  01basics.pdf
# Topic:    T tests with unequal group sizes and unequal variances (Welch's t-test)
# Author:   Edoardo Costantini
# Created:  2022-09-13
# Modified: 2022-09-13

# Define some population values
u1 <- 20
u2 <- 22
s1 <- 16
s2 <- 1
n1 <- 10
n2 <- 20

# Draw data from two groups with unequal variance and sample size
x1 <- rnorm(n1, u1, s1)
x2 <- rnorm(n2, u2, s2)

# Compute degrees of freedom by hand
num <- (sd(x1)^2 / n1 + sd(x2)^2 / n2)^2
den <- sd(x1)^4 / (n1^2 * (n1 - 1)) + sd(x2)^4 / (n2^2 * (n2 - 1))
df_man <- num / den

# Variance
sdelta <- sqrt(sd(x1)^2 / n1 + sd(x2)^2 / n2)

# T statistic
theta <- mean(x2 - x1) # statistic of interest
tstat <- theta / sdelta

# Compute it with base R function
ttestout <- t.test(x1, x2, var.equal = FALSE)

# Comapre with results from baseline R function
data.frame(
  manual = c(
    est = theta,
    tstat = tstat,
    df = df_man,
    pval = pt(tstat, df = df_man) * 2
  ),
  base_R = c(
    est = diff(ttestout$estimate),
    tstat = ttestout$statistic,
    df = ttestout$parameter,
    pval = ttestout$p.value
  )
)