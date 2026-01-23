# Slide 3: Average Future Outlook by Province
rm(list = ls()); cat("\014")

library(readr)
library(dplyr)
library(ggplot2)

futout_clean <- read_csv("Future_Outlook_Clean.csv")

prov <- futout_clean %>%
  # select provinces only, total population
  filter(Geography != "Canada", Gender == "Total") %>%
  mutate(
    # fix names
    Geography = gsub("_", " ", Geography),                
    Geography = ifelse(Geography == "NovaScotia", "Nova Scotia", Geography),
    Indicators = factor(Indicators, 
                        levels = c("Always", "Sometimes", "Rarely"))
  ) %>%
  group_by(Geography, Indicators) %>%
  summarise(AvgPercent = mean(Percent, na.rm = TRUE), .groups = "drop")

# Plot
ggplot(prov, aes(x = Geography, y = AvgPercent, fill = Indicators)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(
    "Always" = "#4E79A7",
    "Sometimes" = "#F28E2B",
    "Rarely" = "#E15759"
  )) +
  labs(
    title = "Average Future Outlook by Province",
    subtitle = "Average percentage of respondents who feel optimistic about their future",
    x = "Province",
    y = "Average Percent (%)",
    fill = "Indicator"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "#C41E3A"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "right",
    panel.grid.minor = element_blank()
  )