# Slide 4: Future Outlook Over Time by Gender (Canada)
rm(list = ls()); cat("\014")

library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)

# Load cleaned dataset
futout_clean <- read_csv("Future_Outlook_Clean.csv")

# Prepare data for Canada, with quarter labels
gender_line <- futout_clean %>%
  filter(Geography == "Canada",
         Gender %in% c("Total", "Men", "Women")) %>%
  mutate(
    QuarterLabel = paste0(year(Date), " Q", quarter(Date)),
    Indicators = factor(Indicators,
                        levels = c("Always", "Sometimes", "Rarely")),
    Gender = factor(Gender, levels = c("Total", "Men", "Women"))
  )

# Line chart: 3 panels (Total, Men, Women)
plot_gender_line <- ggplot(
  gender_line,
  aes(x = QuarterLabel, y = Percent,
      color = Indicators, group = Indicators)
) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 2.8) +
  geom_text(aes(label = round(Percent, 1)),
            vjust = -0.8, size = 3, show.legend = FALSE) +
  
  scale_y_continuous(expand = expansion(mult = c(0.10, 0.15))) +
  
  scale_color_manual(values = c(
    "Always" = "#4E79A7",
    "Sometimes" = "#F28E2B",
    "Rarely" = "#E15759"
  )) +
  
  facet_wrap(~ Gender, ncol = 1) +
  
  labs(
    title = "Future Outlook Over Time by Gender (Canada)",
    subtitle = "Quarterly share of Canadians who feel optimistic, compared across gender groups",
    x = "Quarter",
    y = "% of respondents",
    color = "Indicator"
  ) +
  
  theme_minimal(base_size = 12) +
  theme(
    strip.text = element_text(size = 13, face = "bold"),
    axis.title.x = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 18, face = "bold", color = "#C41E3A"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    panel.grid.minor = element_blank(),
    legend.position = "right"
  )

print(plot_gender_line)