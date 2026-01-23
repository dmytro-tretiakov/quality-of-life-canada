# Big Data 2 - Course Project
# Central Indicators Domain: Future Outlook
# Data Source: Statistics Canada Quality of Life Hub
# https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310084701
# Table 13-10-0847-01: Future outlook by gender and province

rm(list = ls()); cat("\014")

# Load required libraries
library(stringr)
library(readr)
library(dplyr)

# Step 1: Load dataset
futout_raw <- read_csv("Future_Outlook.csv")

# Step 2: View dataset structure
print("Data Structure")
str(futout_raw)
print(paste("Total rows in raw data:", nrow(futout_raw)))
print(paste("Total columns:", ncol(futout_raw)))

print("Column data types")
str(futout_raw)

# Step 3: Data Cleaning
futout_clean <- futout_raw %>%
  
  # Convert Number to numeric (remove commas if present)
  mutate(
    Number = as.numeric(gsub(",", "", Number)),
  ) %>%
  
  # Convert 'Reference period' to date type
  mutate(
    Year = as.numeric(str_extract(`Reference period`, "\\d{4}")),
    
    Date = case_when(
      str_detect(`Reference period`, "Q1") ~ as.Date(paste0(Year, "-01-01")),
      str_detect(`Reference period`, "Q2") ~ as.Date(paste0(Year, "-04-01")),
      str_detect(`Reference period`, "Q3") ~ as.Date(paste0(Year, "-07-01")),
      str_detect(`Reference period`, "Q4") ~ as.Date(paste0(Year, "-10-01"))
    )
  ) %>%
  
  # Remove helper column Year (we don’t need it anymore)
  select(-Year, -`Reference period`)

print("First 5 rows AFTER cleaning:")
head(futout_clean, 5)

str(futout_clean)

# Step 4: Save cleaned dataset
write_csv(futout_clean, "Future_Outlook_Clean.csv")

print("Cleaned dataset saved as 'Future_Outlook_Clean.csv'")


