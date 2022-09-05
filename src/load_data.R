# Read in data form BeadsBox experiments
## All data
data <- read.csv("/Users/klevjer/R Projects/Probabilistic Reasoning/Cleaned data/data_full.csv")
## Fix row names
row.names(data) <- data[,1]
data <- data[,-1]
## Fetch demographics
art1demo <- read.csv("/Users/klevjer/R Projects/Probabilistic Reasoning/Cleaned data/Demo.csv")
## Separate into the two experiments and remove non-beads data
art1exp1 <- data[data$Session == 0,-c(1:6,46:120,138:154,161:181,188:232)]
art1exp2 <- data[data$Session == 1,-c(1:6,46:120,138:154,161:181,188:232)]
art1exp2 <- art1exp2[,c(25:43,52:58,63:64)]


# Read in data from Dice experiments
## Data per experiment
art2exp1 <- read.csv("/Users/klevjer/R Projects/dicetask/data/processed/article4_students1.csv")
art2exp2 <- read.csv("/Users/klevjer/R Projects/dicetask/data/processed/article4_students2.csv")
## Fix row names
row.names(art2exp1) <- art2exp1[,1]
art2exp1 <- art2exp1[,-1]
row.names(art2exp2) <- art2exp2[,1]
art2exp2 <- art2exp2[,-1]
## Fetch demographics & make session variable
art2demo <- rbind(art2exp1[,1:2], art2exp2[,1:2])
art2demo$session <- c(rep(0,nrow(art2exp1)), rep(1,nrow(art2exp2)))
## Remove non-beads data
art2exp1 <- art2exp1[,-1:3]
art2exp2 <- art2exp2[,-1:2]



# Partition into correct data sets
