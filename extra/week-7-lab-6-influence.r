# Project:   stats-meth
# Objective: Exploring influential observations
# Author:    Edoardo Costantini
# Created:   2022-10-11
# Modified:  2022-10-11
# Notes:     Currently in development: results are not working right

# Set up ----------------------------------------------------------------------

    # Clean environment
    rm(list = ls(all = TRUE))

    # Load the packages we need
    library(MASS)     # For the 'Cars93' data
    library(MLmetrics) # for the MSE function

    # Load some data:
    data(Cars93)

# Outliers: detect with externally studentised residuals -----------------------

    # Consider some model
    lmout <- lm(
        Price ~ Horsepower * MPG.city + Passengers * MPG.city + I(Weight^2),
        data = Cars93
    )

    # Compute externally studentised residuals
    esr2 <- rstudent(lmout)
    esr2

    # Create a storing object
    esr2_manual <- rep(NA, length(esr2))

    # Compute externally studentised residuals by hand
    for(i in 1:nrow(Cars93)){

        # Fit the model without the observation
        lmtemp <- lm(
            Price ~ Horsepower * MPG.city + Passengers * MPG.city + I(Weight^2),
            data = Cars93[-i, ]
        )

        # Estiamte the deleted residual
        en <- Cars93[i, "Price"] - predict(lmtemp, Cars93[i, ])

    # Comptue deletion MSE
        MSE_i <- MSE(Cars93[-i, "Price"], fitted(lmtemp))

        # Compute the leverage
        hii <- hatvalues(lmout)[i]

        # Estiamte the deleted resiudal standard error
        se_en <- sqrt(MSE_i * (1 - hii))

        # Compute externally studentized residual
        esr2_manual[i] <- en / se_en
    }

    round(cbind(R = esr2, man = esr2_manual), 3)

    sr2 <- rstudent(lmout)
    sr2

    # Create index plot of studentized residuals:
    plot(sr2)

    # Find outliers
    badSr2 <- which(abs(sr2) > 3)
    badSr2