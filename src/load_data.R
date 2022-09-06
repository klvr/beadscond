####################################################################################################
# Fetches beads and demo data from all experiments  (BeadsBox and Dice)                            #
# Input: CSV files from BeadsBox and Dice experiments containing beads-data, as well as demo       #
# Output: CSV-files containing relevant beads data per experiment (of 4) and demographics          #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 00 ToDo ------------------------------------------------------------------------------------------

## 1: Read in data from OSF, not locally

# 01 Preparation -----------------------------------------------------------------------------------

# Clean up workspare
rm(list = ls())

# 02 Read in data form BeadsBox experiments --------------------------------------------------------

# All data
data <- read.csv("/Users/klevjer/R Projects/Probabilistic Reasoning/Cleaned data/data_full.csv")
## Fix row names
row.names(data) <- data[,1]
data <- data[,-1]

# Fetch demographics and reorder variables
art1demo <- read.csv("/Users/klevjer/R Projects/Probabilistic Reasoning/Cleaned data/Demo.csv")
art1demo <- art1demo[,-1]
art1demo <- art1demo[,c(1,2,4,3)]

# Separate into the two experiments and remove non-beads data
art1exp1 <- data[data$Session == 0,-c(1:6,46:120,138:154,161:181,188:232)]
art1exp2 <- data[data$Session == 1,-c(1:6,46:120,138:154,161:181,188:232)]
art1exp2 <- art1exp2[,c(25:43,52:58,63:64)]

# Reorder variables
art1exp1 <- art1exp1[,c(42,43,40,25,28,31,34,37,57,63,52:56,58,64,26,29,32,35,38,27,30,33,36,39,1,4,
                        7,10,59,65,44:47,60,66,2,5,8,11,3,6,9,12,13,16,19,22,61,67,48:51,62,68,14,
                        17,20,23,15,18,21,24)]
art1exp2 <- art1exp2[,c(18,19,16,1,4,7,10,13,25,27,20:24,26,28,2,5,8,11,14,3,6,9,12,15)]

# 03 Read in data from Dice experiments ------------------------------------------------------------

# Data per experiment
art2exp1 <- read.csv("/Users/klevjer/R Projects/dicetask/data/processed/article4_students1.csv")
art2exp2 <- read.csv("/Users/klevjer/R Projects/dicetask/data/processed/article4_students2.csv")
## Fix row names
row.names(art2exp1) <- art2exp1[,1]
art2exp1 <- art2exp1[,-1]
row.names(art2exp2) <- art2exp2[,1]
art2exp2 <- art2exp2[,-1]

# Fetch demographics, fix colnames & make session variable
art2demo <- rbind(art2exp1[,1:2], art2exp2[,1:2])
colnames(art2demo) <- c("gender","age")
art2demo$session <- c(rep(0,nrow(art2exp1)), rep(1,nrow(art2exp2)))

# Remove non-beads data
art2exp1 <- art2exp1[,-c(1:3)]
art2exp2 <- art2exp2[,-c(1:2)]

# Make a 'experimenter' variable (0: no experimenter)
art2exp1$experimenter <- 0
art2exp2$experimenter <- 0

# Reorder variables
art2exp1 <- art2exp1[,c(1,2,84,13,85,10,14:83,11,12,9,3:8)]
art2exp1 <- art2exp1[,c(1:6,37:76,7:36,77:85)]
art2exp2 <- art2exp2[,c(2,1,77,3,6:75,4,5,76)]
art2exp2 <- art2exp2[,c(1:4,35:74,5:34,75:77)]

# 04 Write files per experiment --------------------------------------------------------------------

# Demographics
write.csv(art1demo[art1demo$session==0,], "data/temp/exp1demo.csv")
write.csv(art1demo[art1demo$session==1,], "data/temp/exp2demo.csv")
write.csv(art2demo[art2demo$session==0,], "data/temp/exp3demo.csv")
write.csv(art2demo[art2demo$session==1,], "data/temp/exp4demo.csv")

# Beads data
write.csv(art1exp1, "data/temp/exp1.csv")
write.csv(art1exp2, "data/temp/exp2.csv")
write.csv(art2exp1, "data/temp/exp3.csv")
write.csv(art2exp2, "data/temp/exp4.csv")