# Title:    Stats & Methods Lab 1 Demonstration Script 2
# Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
# Created:  2018-09-10
# Modified: 2023-01-10

# Set up -----------------------------------------------------------------------

# Clear the workspace:
rm(list = ls(all = TRUE))

# Set your working directory to the "code" directory:
setwd("")

# Install the 'mice' function:
install.packages("mice", repos = "http://cloud.r-project.org")

# Load packages
library(mice) # For missing data descriptives
library(MASS) # For robust stats

# Define the data directory:
dataDir <- "../data/"

# 1. Missing data descriptives -------------------------------------------------

# Read Big Five Invetory (BFI) data from folder
bfi <- readRDS(paste0(dataDir, "bfiANC.rds"))

# Compute variable-wise counts/percents missing/observed:
cm <- colSums(is.na(bfi))
cm
pm <- colMeans(is.na(bfi))
pm

co <- colSums(!is.na(bfi))
co
po <- colMeans(!is.na(bfi))
po

nrow(bfi) - cm
1 - pm

nrow(bfi) - co
1 - po

# Summarize PM:
range(pm)
mean(pm)
median(pm)

# Find variables with PM greater than 10%:
pm[pm > 0.1]

# Find missing data patterns:
missPat <- md.pattern(bfi)
missPat

# Extract the variablewise missing counts:
missPat[nrow(missPat), ]
missPat[nrow(missPat), -ncol(missPat)]

# Extract the patternwise missing counts:
missPat[ , ncol(missPat)]
missPat[-nrow(missPat), ncol(missPat)]

# Extract the counts of pattern membership:
as.numeric(rownames(missPat))
as.numeric(rownames(missPat))[-nrow(missPat)]

# Close the graphics device:
dev.off()

# Compute covariance coverage:
cc <- md.pairs(bfi)$rr / nrow(bfi)
cc

# Extract unique coverage values from the covariance coverage matrix:
cc2 <- cc[lower.tri(cc)]

# Note that we generally don't include the diagonal elements. The diagonal of 
# the covariance coverage matrix contains the proportion of observed cases for 
# each variable. You could, however, obtain the unique coverage value including 
# the diagonal with:
cc[lower.tri(cc, diag = TRUE)]

# Obtain the range of the coverage values (use the unique values, excluding 
# the diagonal):
range(cc2)

# Check that coverage exceeds some threshold:
eps <- 0.8
all(cc2 > eps)

# Find problematic pairs (use entire covariance coverage matrix):
pat <- cc <= eps
apply(pat, 1, function(x) names(x)[x])

# 2. Outlier analysis (univariate) ---------------------------------------------

# Load SAT-test data from folder
tests <- readRDS(paste0(dataDir, "tests.rds")) 

# > 2.1 Boxplot method ---------------------------------------------------------

# Create a boxplot of SATV:
boxplot(tests$SATV)

# Compute the statistics underlying a boxplot:
boxplot.stats(tests$SATV)

# Assign function argument to demonstrate its internals:
x <- tests$SATV

# Define a function to implement the boxplot method:
bpOutliers <- function(x) {
    # Compute inner and outer fences:
    iFen <- boxplot.stats(x, coef = 1.5)$stats[c(1, 5)]
    oFen <- boxplot.stats(x, coef = 3.0)$stats[c(1, 5)]
    
    # Return the row indices of flagged 'possible' and 'probable' outliers:
    list(possible = which(x < iFen[1] | x > iFen[2]),
         probable = which(x < oFen[1] | x > oFen[2])
         )
}

# Remove objects used to demonstrate what happens inside the function
rm(list = c("x", "iFen", "oFen")) # Clean up

# Flag potential outliers in all numeric columns:
lapply(tests[ , -c(1, 2)], FUN = bpOutliers)

# > 2.2 Median Absolute Deviation method ---------------------------------------

# Assign function arguments to demonstrate its internals:
x     <- tests$SATV
cut   <- 2.5
na.rm <- TRUE

# Define a function to implement the MAD method:
madOutliers <- function(x, cut = 2.5, na.rm = TRUE) {
    # Compute the median and MAD of x:
    mX   <- median(x, na.rm = na.rm)
    madX <- mad(x, na.rm = na.rm)
    
    # Return row indices of observations for which |T_MAD| > cut:
    which(abs(x - mX) / madX > cut)
} 

# Remove objects used to demonstrate what happens inside the function
rm(list = c("x", "cut", "na.rm", "mX", "madX")) # Clean up

# Find potential outliers in all numeric columns:
lapply(tests[ , -c(1, 2)], FUN = madOutliers)

# 3. Outlier analysis (multivariate) -------------------------------------------
#    Using the Robust Mahalanobis distance method

# Assign function arguments to demonstrate its internals:
data  <- tests[ , -c(1, 2)]
prob  <- 0.99
ratio <- 0.75
seed  <- 235711

# Define a function to implement a robust version of Mahalanobis distance using
# MCD estimation:
mcdMahalanobis <- function(data, prob, ratio = 0.75, seed = NULL) {
    # Set a seed, if one is provided:
    if(!is.null(seed)) set.seed(seed)
    
    # Compute the MCD estimates of the mean and covariance matrix:
    stats <- cov.mcd(data, quantile.used = floor(ratio * nrow(data)))
    
    # Compute robust squared Mahalanobis distances
    md <- mahalanobis(x = data, center = stats$center, cov = stats$cov)
    
    # Find the cutoff value:
    crit <- qchisq(prob, df = ncol(data))
    
    # Return row indices of flagged observations:
    which(md > crit)
}

# Remove objects used to demonstrate what happens inside the function
rm(list = c("data", "prob", "ratio", "stats", "md", "crit")) # Clean up

# Flag potential multivariate outliers:
mcdMahalanobis(data = tests[ , -c(1, 2)], prob = 0.99, seed = 235711)

