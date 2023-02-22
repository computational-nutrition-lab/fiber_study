
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

# Change the variable name from Gender to Sex
colnames(map)[grep("Gender", colnames(map))] <- "Sex"

#Change the variable name from Usual_bristol to Bristol
colnames(map)[grep("Usual_bristol", colnames(map))] <- "Bristol"
grep("Bristol", colnames(map))

#Change the variable name from physact to Physical Activity
colnames(map)[grep("Physact", colnames(map))] <- "Physical Activity"

#Change the variable name to Baseline Weight (kg)
colnames(map)[grep("Baseline_Weight_kg", colnames(map))] <- "Baseline Weight (kg)"
table(map$`Baseline Weight (kg)`)

#Change the variable name to Movements per week
colnames(map)[grep("Movements_per_week", colnames(map))] <- "Movements per week"

#recode gas_leakage to Binary leakage
map$Leakage <- ifelse(grepl("f", map$Gas_leakage), "Yes", "No")

#recode Physical Activity to binary 
map$`Physical Activity` <- ifelse(map$`Physical Activity` >= 3, "≥ 3 days", "< 3 days")

table(map$`Physical Activity`)

# Fix data issues
# noticed that one participant coded 1.5 for bss
map[map$StudyID == "FS10", colnames(map) == "Bristol"] <- 2

# want to make a table of participant data for TRE and Control
# check that both of these are the same
sum(map$StudyID == unique(tax_map$StudyID))
table(map$StudyID)
table(tax_map$StudyID)

#demographics table 
table1 <-gtsummary::tbl_summary(map, 
                      include = c(  "Sex", 
                                      "Age", 
                                      "Leakage",
                                      "Baseline Weight (kg)",
                                      "Bristol", 
                                      "Movements per week", 
                                      "Physical Activity"), 
                      by = Group,
                      type = list(Sex ~ "categorical", 
                                  Leakage ~ "categorical", 
                                  `Physical Activity` ~ "categorical",
                                   Bristol ~ "continuous", 
                                   `Movements per week` ~ "continuous"),
                       statistic = all_continuous() ~ "{mean}, ({min}, {max})", 
                       digits = list(Bristol ~ c(1, 0, 0), 
                                     `Movements per week` ~ c(2, 0, 0)))
                                    

table1
                  


flextable::save_as_docx(as_flex_table(table1), path = "Output/table1.docx")
