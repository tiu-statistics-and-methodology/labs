# Lecture:  05mlr.pdf
# Topic:    Multiple linear regression in R
# Author:   Edoardo Costantini
# Created:  2022-09-13
# Modified: 2022-09-13

# Prepare the environment -----------------------------------------------------

    # Define variables
    y <- mtcars$mpg
    x1 <- mtcars$cyl
    x2 <- mtcars$wt
    n <- nrow(mtcars)
    p <- 2 # numer of prameters: 1 intercept, 2 regression coefficients

    # Fit model
    lmfit <- lm(y ~ x1 + x2)

    # Compute summary
    summary(lmfit)

# Compute reported values by hand ---------------------------------------------

    # T values
    b1_hat <- lmfit$coefficients["x1"]
    b1_hat_se <- coef(summary(lmfit))["x1", "Std. Error"]
    b1_hat_tv <- b1_hat / b1_hat_se

    # P-values
    b1_hat_pval <- pt(q = b1_hat_tv, df = n - p - 1, lower.tail = TRUE)*2

    # Compare with lm function results
    coef(summary(lmfit))["x1", ]
    c(tval = b1_hat_tv, pval = b1_hat_pval)

# R2 significance testing -----------------------------------------------------

    # Compute fitted values
    y_hat <- fitted(lmfit)

    # Compute residuals
    Er <- TSS <- sum( (y - mean(y))^2 )   # baseline prediction error
    Ef <- SSE <- sum((y - y_hat)^2) #     # prediction error

    # Compute degrees of freedom
    dfR <- (n - 0 - 1)
    dfF <- (n - p - 1)

    # Compute the f statistic
    Fstat <- ((Er - Ef) / (dfR - dfF)) / (Ef / dfF)
    summary(lmfit)$fstatistic

    # Null hypothesis distribution
    df1 <- p
    df2 <- n - p - 1
    plot(density(rf(1e4, df1, df2)), xlim = c(0,30))
    abline(v = Fstat)

    pf(Fstat, df1, df2, lower.tail = FALSE)

    # Relationship to R^2
    R2 <- 1 - Ef/Er
    summary(lmfit)$r.squared
    # Not the same as the F score, but:
    # - in Ef/Er, if Ef is bigger, R2 is smaller -> model is not good
    # - in Er - Ef, if Ef is bigger, F is smaller -> model is not good

# R2 model comparison ---------------------------------------------------------

    # Define objectes you'll need
    y <- mtcars$mpg     # store the dependent variablne
    n <- nrow(mtcars)   # store the sample size

    # Model 1
    lmfit1 <- lm(mpg ~ cyl, data = mtcars)

    # Model 2
    lmfit2 <- lm(mpg ~ cyl + wt + hp, data = mtcars)

    # Test R2 change with anova R-function
    R2_change <- anova(lmfit1, lmfit2)

    # Compute residuals
    TSS <- sum((y - mean(y))^2)
    Er <- SSEr <- sum((y - predict(lmfit1))^2) # baseline prediction error
    Ef <- SSEf <- sum((y - predict(lmfit2))^2) # prediction error
    R2_change$RSS

    # Compute degrees of freedom
    dfR <- (n - (length(lmfit1$coefficients) - 1) - 1)
    dfF <- (n - (length(lmfit2$coefficients) - 1) - 1)
    R2_change$Res.Df

    # Compute the f statistic
    Fstat <- ((Er - Ef) / (dfR - dfF)) / (Ef / dfF)
    R2_change$F

    # Anova output
    pf(Fstat, df1 = dfR - dfF, df2 = dfF, lower.tail = FALSE)
    R2_change$'Pr(>F)'

    # Null hypothesis distribution
    plot(density(rf(1e4, df1 = dfR - dfF, df2 = dfF)), xlim = c(0, 20))
    abline(v = Fstat)

# Relationship of F and R^2 ---------------------------------------------------

    # Define R2 for the two models
    R2f <- 1 - SSEf / TSS
    R2r <- 1 - SSEr / TSS

    # Compute difference in R2 between full and restricted model
    R2_diff <- R2f - R2r
    R2_diff 

    # Check how you would compute the Fstat starting from R2_diff
    all.equal(
        target = Fstat,
        current = R2_diff * TSS / (dfR - dfF) / (Ef / dfF)
    )

    # Check how you would compute the R2_diff starting from Fstat
    all.equal(
        target = R2_diff,
        current = Fstat * (Ef / dfF) * (dfR - dfF) / TSS
    )

# > How do we get there? ------------------------------------------------------

# 1. Consider the usual formula to compute the F statistic

    # Check the current value of F stat returned by anova function
    R2_change$F[2]

    # Compute the F statistic with the general formula
    ((Er - Ef) / (dfR - dfF)) / (Ef / dfF)

    # Note that Er = SSEr and Ef = SSEf
    ((SSEr - SSEf) / (dfR - dfF)) / (Ef / dfF)

# 2. Consider the usual formula to compute the change in R-square

    # The R change is their difference
    R2f - R2r

    # Which we can write in full
    (1 - SSEf / TSS ) - (1 - SSEr / TSS)

# 3. Simplify this formula by removing the parenthesis

    # Carry over the minus
    1 - SSEf / TSS - 1 + SSEr / TSS

    # 1 - 1 = 0
    SSEr / TSS - SSEf / TSS

    # Write with the common denominator
    (SSEr - SSEf) / TSS

# 5. Solve for R2_diff = (SSEr - SSEf) / TSS for (SSEr - SSEf)

    # Multiply left and write by TSS: TSS * R2_diff = (SSEr - SSEf)
    all.equal(R2_diff * TSS, (SSEr - SSEf))

    # Replace SSEr - SSEf with its equivalent R2_diff * TSS in the F general formula
    (R2_diff * TSS / (dfR - dfF)) / (Ef / dfF)

    # Compare to original F statistic
    Fstat

    # Yay!