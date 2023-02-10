alpha <- mb_sample_metadata_with_alpha_div
length(alpha)
head(alpha)

Meta <- Fiber.Aliquots.Metadata
length(Meta)

group_cols <- c("#208eb7", "#87d4cf")

names(group_cols) <- c("High", "Low")

seq_cols <- c("#57377e","#c0e087")

names(seq_cols) <- c("LowHigh", "HighLow")

# create participant characteristic table
install.packages("gtsummary")
install.packages("flextable")

library(gtsummary)
library(flextable)

setwd("/Users/juliajallo/Documents/Spring 2023 Grad School/ILE")

map <- read.delim("/Users/juliajallo/Documents/Spring 2023 Grad School/ILE/ILE data/Subject_Metadata.tsv")
tax_map <- read.delim("/Users/juliajallo/Documents/Spring 2023 Grad School/ILE/ILE data/mb_sample_metadata_with_alpha_div.txt")
num_samp <- table(tax_map$StudyID) 


# want to make a table of participant data for TRE and Control
# check that both of these are the same
sum(map$StudyID == unique(tax_map$StudyID))
table(map$StudyID)
table(tax_map$StudyID)


table(map$Age)
table(map$Gas_leakage)
table(map$Usual_bristol)
table(map$Movements_per_week)
table(map$Physact)


# need to add the group for this 
assignment <- unique(tax_map[,colnames(tax_map) %in% 
c("participant_ID","randomization_assignment")])
assignment$participant_ID == map$StudyID
