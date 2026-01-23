# Slide 5: Average Future Outlook by Province and Gender
rm(list = ls()); cat("\014")

library(dplyr)
library(ggplot2)
library(readr)

# Load cleaned dataset
futout_clean <- read_csv("Future_Outlook_Clean.csv")

# Prepare province-level average data by gender
prov_heatmap_gender <- futout_clean %>%
  filter(Geography != "Canada",
         Gender %in% c("Total", "Men", "Women")) %>%
  mutate(
    Geography = gsub("_", " ", Geography),
    Indicators = factor(Indicators, levels = c("Always", "Sometimes", "Rarely")),
    Gender = factor(Gender, levels = c("Total", "Men", "Women"))
  ) %>%
  group_by(Geography, Indicators, Gender) %>%
  summarise(
    AvgPercent = round(mean(Percent, na.rm = TRUE), 1),
    .groups = "drop"
  ) %>%
  
  # Create internal combined column for positioning
  mutate(
    Column = paste(Indicators, Gender, sep = "_"),
    
    # Simplify label shown on the x-axis
    Label = Gender
  )

# Order columns properly
column_order <- c(
  "Always_Total", "Always_Men", "Always_Women",
  "Sometimes_Total", "Sometimes_Men", "Sometimes_Women",
  "Rarely_Total", "Rarely_Men", "Rarely_Women"
)

prov_heatmap_gender$Column <- factor(prov_heatmap_gender$Column,
                                     levels = column_order)

# Plot heatmap
plot_heat_gender <- ggplot(prov_heatmap_gender,
                           aes(x = Column, y = Geography, fill = Indicators)) +
  
  geom_tile(color = "white", linewidth = 0.4) +
  
  geom_text(aes(label = AvgPercent),
            color = "black", size = 3.5, fontface = "bold") +
  
  scale_fill_manual(values = c(
    "Always"    = "#4E79A7",
    "Sometimes" = "#F28E2B",
    "Rarely"    = "#E15759"
  )) +
  
  # Replace x-axis text with simplified Gender labels
  scale_x_discrete(labels = prov_heatmap_gender$Label) +
  
  labs(
    title = "Average Future Outlook by Province and Gender",
    subtitle = "Heatmap comparing optimism patterns across demographic groups",
    fill = "Indicator"
  ) +
  
  theme_minimal(base_size = 11) +
  theme(
    axis.title = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(size = 18, face = "bold", color = "#C41E3A"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    panel.grid = element_blank(),
    legend.position = "right"
  )

print(plot_heat_gender)
