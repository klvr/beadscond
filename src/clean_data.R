####################################################################################################
# Cleans and summaries beads data (prep for analyses)                                              #
# Input: CSV files from each experiment (and demographics)                                         #
# Output: CSV-files containing cleaned beads, and collected demographics                           #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 01 Preparation -----------------------------------------------------------------------------------

# Clean up workspace
rm(list = ls())

# 02 Load data -------------------------------------------------------------------------------------

# Demographics
exp1demo <- read.csv("data/temp/exp1demo.csv")[,-1]
exp2demo <- read.csv("data/temp/exp2demo.csv")[,-1]
exp3demo <- read.csv("data/temp/exp3demo.csv")[,-1]
exp4demo <- read.csv("data/temp/exp4demo.csv")[,-1]

# Beads data
exp1 <- read.csv("data/temp/exp1.csv")
exp2 <- read.csv("data/temp/exp2.csv")
exp3 <- read.csv("data/temp/exp3.csv")
exp4 <- read.csv("data/temp/exp4.csv")
## Set row names
rownames(exp1) <- exp1[,1]
exp1 <- exp1[,-1]
rownames(exp2) <- exp2[,1]
exp2 <- exp2[,-1]
rownames(exp3) <- exp3[,1]
exp3 <- exp3[,-1]
rownames(exp4) <- exp4[,1]
exp4 <- exp4[,-1]

# 03 Demo data -------------------------------------------------------------------------------------

# Set/correct session data
exp1demo$session <- 1
exp2demo$session <- 2
exp3demo$session <- 3
exp4demo$session <- 4

# Set area of study (1: confirmed psychology student or participant from psychology course)
exp3demo$study <- 1
exp4demo$study <- 1

# Collect into one file
demographics <- rbind(exp1demo, exp2demo, exp3demo, exp4demo)

# 04 Remove missing data ---------------------------------------------------------------------------

# Record and remove all missing beads data
## For exp1: Simply missing all beads-variants data
exp1missing <- c(sum(rowSums(is.na(exp1))>60), "exp1")
exp1 <- exp1[rowSums(is.na(exp1))<60,]
## For exp2: Missing all two-urn beads data
exp2missing <- c(sum(rowSums(is.na(exp2[,c(4:8)]))>4), "exp2")
exp2 <- exp2[rowSums(is.na(exp2[,c(4:8)]))<4,]
## For exp3: Missing data in both beads variants
exp3missing <- c(sum((rowSums(is.na(exp3[,c(7:46)]))>10) + (rowSums(is.na(exp3[,c(47:76)]))>10)==2),
                 "exp3")
exp3 <- exp3[(rowSums(is.na(exp3[,c(7:46)]))>10) + (rowSums(is.na(exp3[,c(47:76)]))>10)<2,]
## For exp4: Missing data in both beads variants
exp4missing <- c(sum((rowSums(is.na(exp4[,c(5:44)]))>10) + (rowSums(is.na(exp4[,c(45:74)]))>10)==2),
                 "exp4")
exp4 <- exp4[(rowSums(is.na(exp4[,c(5:44)]))>10) + (rowSums(is.na(exp4[,c(45:74)]))>10)<2,]

# Duplicates
## Some participants in exp3 have data for both beads-task variants.
## only the first responses (in time) will be kept.
exp3double <- c(sum((rowSums(is.na(exp3[,c(7:46)]))>10) + (rowSums(is.na(exp3[,c(47:76)]))>10)==0),
                "exp3")
## These are found using:
## rownames(exp3[(rowSums(is.na(exp3[,c(7:46)]))>10) + (rowSums(is.na(exp3[,c(47:76)]))>10)==0,])
## 33564, 36473, 43931, & 50371 - All of which either indicated that they hadn't played the task
## (even though they had) or failed the control-question, giving them the task again.
## Manual inspection of the raw files show that:
## For 33564, 43931 & 50371: The ABDecision variant data should be kept
## For 36473: The Guess variant data should be kept
exp3[rownames(exp3)==33564,c(7:46)] <- NA
exp3[rownames(exp3)==43931,c(7:46)] <- NA
exp3[rownames(exp3)==50371,c(7:46)] <- NA
exp3[rownames(exp3)==36473,c(47:76)] <- NA

# Pilot data
## One participant is pilot data (completed the form before it was sent out, and 3 times): 45496,
## these responses are manually removed (exp3).
exp3pilot <- c(1, "exp3")
exp3 <- exp3[!rownames(exp3)==45496,]

# Save participants and data removed
missing <- rbind(exp1missing, exp2missing, exp3missing, exp4missing, exp3double, exp3pilot)

# 05 Clean beads data ------------------------------------------------------------------------------
