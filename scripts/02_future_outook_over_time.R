# Slide 2: Future Outlook Over Time (Canada Only)
rm(list = ls()); cat("\014")

library(dplyr)
library(ggplot2)
library(lubridate)

# Load cleaned dataset
futout_clean <- read_csv("Future_Outlook_Clean.csv")

# Filter only Canada & Total, create quarter labels
canada_time <- futout_clean %>%
  filter(Geography == "Canada", Gender == "Total") %>%
  mutate(
    QuarterLabel = paste0(year(Date), " Q", quarter(Date)),
    Indicators = factor(Indicators, levels = c("Always", "Sometimes", "Rarely"))
  )

# Plot
plot_time <- ggplot(canada_time, 
                    aes(x = Date, y = Percent, 
                        color = Indicators, group = Indicators)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 3.5) +
  
  # Bigger percentage labels
  geom_text(aes(label = round(Percent, 1)),
            vjust = -0.9, size = 4.2, fontface = "bold",
            show.legend = FALSE) +
  
  # Use custom quarter labels on x-axis
  scale_x_date(
    breaks = canada_time$Date,
    labels = canada_time$QuarterLabel
  ) +
  
  scale_color_manual(values = c(
    "Always" = "#4E79A7",
    "Sometimes" = "#F28E2B",
    "Rarely" = "#E15759"
  )) +
  
  labs(
    title = "Future Outlook Over Time (Canada)",
    subtitle = "Quarterly share of respondents who feel optimistic about their future",
    x = "Period",
    y = "% of respondents",
    color = "Indicator"
  ) +
  
  theme_minimal(base_size = 12) +
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 18, face = "bold", color = "#C41E3A"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    panel.grid.minor = element_blank(),
    legend.position = "right"
  )

print(plot_time)