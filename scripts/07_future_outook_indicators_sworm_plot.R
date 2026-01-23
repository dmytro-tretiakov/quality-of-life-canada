# Slide 7: Respondent Count Distribution by Indicator
rm(list = ls()); cat("\014")

library(dplyr)
library(ggplot2)
library(readr)

# Load cleaned dataset
futout_clean <- read_csv("Future_Outlook_Clean.csv")

# Prepare data
swarm_data <- futout_clean %>%
  filter(
    Geography == "Canada",
    Gender == "Total",       # <<–– KEEP ONLY TOTAL
    !is.na(Number)
  ) %>%
  mutate(
    Indicators = factor(Indicators,
                        levels = c("Always", "Sometimes", "Rarely"))
  )

# Swarm plot using jitter
swarm_plot <- ggplot(
  swarm_data,
  aes(x = Indicators, y = Number, color = Indicators)
) +
  geom_jitter(width = 0.18, alpha = 0.7, size = 2) +
  
  scale_color_manual(values = c(
    "Always" = "#4E79A7",
    "Sometimes" = "#F28E2B",
    "Rarely" = "#E15759"
  )) +
  
  labs(
    title = "Respondent Count Distribution by Indicator",
    subtitle = "Swarm plot showing quarterly total respondent counts for optimism levels in Canada",
    x = "Indicator",
    y = "Number of respondents",
    color = "Indicator"
  ) +
  
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "#C41E3A"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    axis.title.x = element_blank(),
    panel.grid.minor = element_blank()
  )

print(swarm_plot)
