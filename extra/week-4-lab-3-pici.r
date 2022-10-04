# Lecture:  06prediction.pdf
# Topic:    Confidence and prediction intervals
# Author:   Edoardo Costantini
# Created:  2022-09-19
# Modified: 2022-09-19

# Prepare data ----------------------------------------------------------------

# Create index to split data into train and test
ind <- sample(
    c(
        rep("train", 20),
        rep("test", nrow(mtcars) - 20)
    )
)

# Apply index to mtcars data
mtcars_split <- split(mtcars, ind)

# Devide the data
test <- mtcars_split$test
train <- mtcars_split$train

# Fit model
lm_out <- lm(mpg ~ wt, data = train)

# Obtain predictions
y_hat <- predict(lm_out, newdata = train)
y_hat_test <- predict(lm_out, newdata = test)

# Define observed outcome
y <- train$mpg
y_test <- test$mpg

# Compute MSE on training data
n <- nrow(train)
sigma2 <- mse <- (sum((y_hat - y)^2)) / (n - 1 - 1)

# Prediction interval for new observation -------------------------------------

# Prediction interval
y_hat_test_pi <- predict(
    lm_out,
    newdata = test, 
    interval = "prediction"
)

# Extract x value for the new observation
xh <- test[1, "wt"]

# Extract predicted value for first new observation
yhh <- y_hat_test[1]

# Extract x value from training data
x <- train[, "wt"]
xb <- mean(train[, "wt"])

# Define critical value for the confidence/prediction interval
tcrit <- qt(.975, df = nrow(train) - 2)

# Compute manual standard error of prediction for future outcome
se_pr <- sqrt(sigma2 * (1 + 1 / n + (xh - xb)^2 / sum((x - xb)^2)))

# Compare R output with manual computation
rbind(
    R = y_hat_test_pi[1, 2:3],
    manual = c(
        yhh - tcrit * se_pr,
        yhh + tcrit * se_pr
    )
)

# Confidence interval for conditinoal mean (y_hat) ----------------------------

# Confidence interval
y_hat_test_ci <- predict(
    lm_out,
    newdata = test,
    interval = "confidence",
    se.fit = TRUE
)

# Compute manual standard error of predicted mean (of conditional mean)
y_hat_test_ci$se.fit[1]
se_cm <- sqrt(sigma2 * (1 / n + (xh - xb)^2 / sum((x - xb)^2)))

# Compute manual confidence interval of y_hat (conditional mean)
manual_ciyh <- c(
    yhh - tcrit * se_cm,
    yhh + tcrit * se_cm
)

# Compare R output with manual computation
rbind(
    R = y_hat_test_ci$fit[1, 2:3],
    manual = c(
        yhh - tcrit * se_cm,
        yhh + tcrit * se_cm
    )
)
