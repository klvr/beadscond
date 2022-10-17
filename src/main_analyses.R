####################################################################################################
# Analyses for the effects of various beads conditions                                             #
# Input: CSV files from each experiment (processed)                                                #
# Output: Relevant analyses for article (in workspace)                                             #
# NB: Seperate script for figures / graphics                                                       #
# Kristoffer Klevjer - github.com/klvr - klevjer(a)gmail.com                                       #
####################################################################################################

# 01 Preparation -----------------------------------------------------------------------------------

# Clean up workspace
rm(list = ls())

# 02 Load data -------------------------------------------------------------------------------------

demographics <- read.csv("data/processed/demographics.csv")[,-1]
exp1 <- read.csv("data/processed/exp1.csv")[,-1]
exp2 <- read.csv("data/processed/exp2.csv")[,-1]
exp3 <- read.csv("data/processed/exp3.csv")[,-1]
exp4 <- read.csv("data/processed/exp4.csv")[,-1]

# 03 Demographics ----------------------------------------------------------------------------------

# 04 Testing situation -----------------------------------------------------------------------------

# To investigate the effects of being tested solo v. group v. remote:
## Abstract: Solo v. group
### First trial
mean(exp1$BeadsTwojarDtD1, na.rm = TRUE)
sd(exp1$BeadsTwojarDtD1, na.rm = TRUE)
mean(exp2$BeadsTwojarDtD1, na.rm = TRUE)
sd(exp2$BeadsTwojarDtD1, na.rm = TRUE)
### All trials
mean(exp1$BeadsTwojarDtDOverall, na.rm = TRUE)
sd(exp1$BeadsTwojarDtDOverall, na.rm = TRUE)
mean(exp2$BeadsTwojarDtDOverall, na.rm = TRUE)
sd(exp2$BeadsTwojarDtDOverall, na.rm = TRUE)
## Cover-story: Group v. remote
mean(exp3$BeadsFishDtD1, na.rm = TRUE)
sd(exp3$BeadsFishDtD1, na.rm = TRUE)
mean(exp4$BeadsFishDtD1, na.rm = TRUE)
sd(exp4$BeadsFishDtD1, na.rm = TRUE)

neinei <- as.data.frame(rbind(cbind(rep("Exp1", nrow(exp1)),exp1$BeadsTwojarDtD1), cbind(rep("Exp2", nrow(exp2)), exp2$BeadsTwojarDtD1)))
neinei$V1 <- as.factor(neinei$V1)
neinei$V2 <- as.numeric(neinei$V2)
mean(neinei[neinei$V1=="Exp1",2]==1, na.rm = TRUE)
mean(neinei[neinei$V1=="Exp2",2]==1, na.rm = TRUE)
ggplot2::ggplot(data = neinei, aes(x = V2, fill = V1)) + geom_density(aes(alpha = 0.7)) + xlab("Pre-removal Exp12")
neinei[!neinei$V2!=1,2] <- NA
ggplot2::ggplot(data = neinei, aes(x = V2, fill = V1)) + geom_density(aes(alpha = 0.7)) + xlab("Post-removal Exp12")

neinei <- as.data.frame(rbind(cbind(rep("Exp3", nrow(exp3)),exp3$BeadsFishDtD1), cbind(rep("Exp4", nrow(exp4)), exp4$BeadsFishDtD1)))
neinei$V1 <- as.factor(neinei$V1)
neinei$V2 <- as.numeric(neinei$V2)
mean(neinei[neinei$V1=="Exp3",2]==1, na.rm = TRUE)
mean(neinei[neinei$V1=="Exp4",2]==1, na.rm = TRUE)
ggplot2::ggplot(data = neinei, aes(x = V2, fill = V1)) + geom_density(aes(alpha = 0.7)) + xlab("Pre-removal Exp34")
neinei[!neinei$V2!=1,2] <- NA
ggplot2::ggplot(data = neinei, aes(x = V2, fill = V1)) + geom_density(aes(alpha = 0.7)) + xlab("Post-removal Exp34")

                