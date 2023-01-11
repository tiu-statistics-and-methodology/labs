# Title:    Stats & Methods Lab 1 Demonstration Script 1
# Author:   Kyle M. Lang, Edo
# Created:  2018-09-10
# Modified: 2023-01-10

# Set up -----------------------------------------------------------------------

# Clear the workspace:
rm(list = ls(all = TRUE))

# Set your working directory to the "code" directory:
setwd("")

# 1. File I/O ------------------------------------------------------------------

# Define two character vectors
s1 <- "Hello"
s2 <- "World!"

# Paste the strings contained in character vectors together
paste(s1, s2)
paste(s1, s2, sep = "_")
paste0(s1, s2)

# We can use 'paste' to build file paths:
dataDir  <- "../data/"
outDir   <- "../output/"
fileName <- "mtcars.rds"

# Read data from disk:
dat1 <- readRDS(paste0(dataDir, fileName))

# We have two versions of 'read.csv':
dat1 <- read.csv(paste0(dataDir, "mtcars.csv"), row.names = 1)   # US format
dat1 <- read.csv2(paste0(dataDir, "mtcars2.csv"), row.names = 1) # EU format

# Look at the top of the dataset:
head(dat1)

# See the order stats of each variable:
summary(dat1)

# See the internal structure of the object:
str(dat1)

# Save the summary:
saveRDS(summary(dat1), file = paste0(outDir, "dat1_summary.rds"))

# 2. Compute Descriptive Stats -------------------------------------------------

# Mean:
mean(dat1$wt)

# Variance:
var(dat1$wt)

# SD:
sd(dat1$wt)

# Median:
median(dat1$wt)

# Range:
range(dat1$wt)
min(dat1$wt)
max(dat1$wt)

# Quantiles:
quantile(dat1$wt, prob = c(0.05, 0.95))

# Calculate the correlation matrix
cor(dat1)
cor(dat1, method = "spearman")
cor(dat1, method = "kendall")

# Calculate covariance matrix
cov(dat1)

# Compute variable means:
colMeans(dat1)

# Compute variable SDs:
sapply(dat1, FUN = sd)   # Only works for data.frames
apply(dat1, 2, FUN = sd) # Also works for matrices

# Compute variable medians:
sapply(dat1, FUN = median)
apply(dat1, 2, FUN = median)

# Compute frequency tables:
table(dat1$carb)
table(trans = dat1$am, gears = dat1$gear)
with(dat1, table(cyl, carb))

# 3. Simple Inferential Analyses -----------------------------------------------

# Simple mean differences:
t.test(mpg ~ am, var.equal = TRUE, data = mtcars)
t.test(mpg ~ am, var.equal = FALSE, data = mtcars)

# Test mean differences with direction hypothesis:
t.test(mpg ~ am, alternative = "less", data = mtcars)

# Alternatively:
mpgA <- with(mtcars, mpg[am == 0]) # Subset mpg for automatic trans
mpgM <- with(mtcars, mpg[am == 1]) # Subset mpg for manual trans

t.test(x = mpgA, y = mpgM, alternative = "less") # D = mX - mY

# Bivariate correlation:
cor(x = mtcars$wt, y = mtcars$mpg)
cor.test(x = mtcars$wt, y = mtcars$mpg)

# Correlation with a directional hypothesis:
cor.test(x = mtcars$disp, y = mtcars$qsec, alternative = "less")

# 4. Intro to plotting ---------------------------------------------------------

tests <- readRDS(paste0(dataDir, "tests.rds"))

# Summarize the dataset:
summary(tests)

# Generate a marginal boxplot of ACT score:
boxplot(tests$ACT)

# Generate boxplots of SAT scores with grouping by gender:
boxplot(SATV ~ gender, data = tests)
boxplot(SATQ ~ gender, data = tests)

# Generate a histogram of age:
hist(tests$age)

# Generate a kernel density plot of age:
plot(density(tests$age))

# Overlay normal density onto histogram:
hist(tests$age, probability = TRUE)

m <- mean(tests$age)
s <- sd(tests$age)
x <- seq(min(tests$age), max(tests$age), length.out = 1000)

lines(x = x, y = dnorm(x, mean = m, sd = s))

# Create a bi-variate scatterplot:
plot(x = tests[ , "age"], y = tests[ , "SATV"])

# Create a scatterplot matrix:
pairs(tests[ , -c(1, 2)])
