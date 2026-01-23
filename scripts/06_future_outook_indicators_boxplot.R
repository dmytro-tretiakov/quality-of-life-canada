# Slide 6: Respondent Count Variation by Indicator
rm(list = ls()); cat("\014")

library(dplyr)
library(ggplot2)
library(readr)

futout_clean <- read_csv("Future_Outlook_Clean.csv")

canada_box <- futout_clean %>%
  filter(Geography == "Canada",
         Gender == "Total",
         !is.na(Number)) %>%
  mutate(
    Indicators = factor(Indicators,
                        levels = c("Always", "Sometimes", "Rarely"))
  )

box_plot <- ggplot(canada_box, aes(x = Indicators, y = Number, fill = Indicators)) +
  geom_boxplot(alpha = 0.85, width = 0.6, outlier.color = "gray30") +
  
  scale_fill_manual(values = c(
    "Always" = "#4E79A7",
    "Sometimes" = "#F28E2B",
    "Rarely" = "#E15759"
  )) +
  
  labs(
    title = "Respondent Count Variation by Indicator",
    subtitle = "Boxplot showing median, quartiles, and spread of optimism response counts in Canada",
    x = "Indicator",
    y = "Number of respondents",
    fill = "Indicator"
  ) +
  
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "#C41E3A"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    axis.title.x = element_blank(),
    panel.grid.minor = element_blank()
  )

print(box_plot)
