# Slide 1: Summary Table + Pie Chart
rm(list = ls()); cat("\014")

# Load libraries
library(readr)
library(dplyr)

# Load cleaned dataset
futout_clean <- read_csv("Future_Outlook_Clean.csv")

# Summary Table

summary_table <- futout_clean %>%
  filter(Geography == "Canada") %>%
  group_by(Indicators, Gender) %>%
  summarise(
    Avg_Number = round(mean(Number, na.rm = TRUE), 1),
    Avg_Percent = round(mean(Percent, na.rm = TRUE), 1),
    .groups = "drop"
  ) %>%
  mutate(
    Indicators = factor(Indicators, levels = c("Always", "Sometimes", "Rarely")),
    Gender = factor(Gender, levels = c("Total", "Men", "Women"))
  ) %>%
  arrange(Indicators, Gender)

print(summary_table)

# Summary Statistics

summary_stats <- futout_clean %>%
  filter(Geography == "Canada") %>%
  group_by(Indicators) %>%
  summarise(
    Min_Percent = min(Percent, na.rm = TRUE),
    Max_Percent = max(Percent, na.rm = TRUE),
    Mean_Percent = round(mean(Percent, na.rm = TRUE), 2),
    Median_Percent = median(Percent, na.rm = TRUE),
    SD_Percent = round(sd(Percent, na.rm = TRUE), 2),
    .groups = "drop"
  ) %>%

  mutate(
    Indicators = factor(Indicators, 
                        levels = c("Always", "Sometimes", "Rarely"))
  ) %>%
  arrange(Indicators)

print(summary_stats)


# Pie Chart

pie_data <- futout_clean %>%
  group_by(Indicators) %>%
  summarise(AvgPercent = mean(Percent), .groups = "drop")

labels <- paste0(
  pie_data$Indicators,
  " (", round(pie_data$AvgPercent, 1), "%)"
)

colors <- c("#4E79A7", "#F28E2B", "#E15759")

pie(
  pie_data$AvgPercent,
  labels = labels,
  col = colors,
  border = "white",
  cex = 1.2,
  main = "Distribution of Future Outlook Indicators (Avg %)"
)
box(lwd = 2, col = "gray40")






