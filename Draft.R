taxa <- tax_norm_s
length(taxa)

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

map <- read.delim("/Users/juliajallo/Documents/Spring 2023 Grad School/ILE/Subject_Metadata.tsv")
tax_map <- read.delim("/Users/juliajallo/Documents/Spring 2023 Grad School/ILE/mb_sample_metadata_with_alpha_div.txt")
num_samp <- table(tax_map$SampleID)
#figure out what two datasets you should be looking at here.. the ID names for 
#both datasets are not lining up below

# want to make a table of participant data for TRE and Control
# check that both of these are the same
sum(map$StudyID == unique(tax_map$SampleID))

# need to add the group for this 
assignment <- unique(tax_map[,colnames(tax_map) %in% c("participant_ID","randomization_assignment")])
assignment$participant_ID == map$ID


