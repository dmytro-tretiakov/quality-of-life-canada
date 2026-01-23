# Slide 9: Future Outlook - Summary
rm(list = ls()); cat("\014")

library(dplyr)
library(ggplot2)
library(readr)
library(patchwork)
library(lubridate)

futout_clean <- read_csv("Future_Outlook_Clean.csv")

col_always    <- "#4E79A7"
col_sometimes <- "#F28E2B"
col_rarely    <- "#E15759"

# Unified Theme - all tiles use same title style
tile_theme <- theme_void() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5),
    plot.margin = margin(10, 10, 10, 10)
  )

# TILE 1 — Canada (Always)
tile1_data <- futout_clean %>%
  filter(Geography == "Canada", Gender == "Total", Indicators == "Always") %>%
  summarise(Avg = round(mean(Percent), 1))

tile1 <- ggplot(tile1_data, aes(1, 1)) +
  geom_text(aes(label = paste0(Avg, "%")),
            size = 18, color = col_always, fontface = "bold") +
  labs(
    title = "Canada's Average Optimism",
    subtitle = "Most Canadians feel optimistic about their future."
  ) +
  tile_theme

# TILE 2 — Gender comparison
tile2_data <- futout_clean %>%
  filter(Geography == "Canada", Indicators == "Always",
         Gender %in% c("Women", "Men")) %>%
  group_by(Gender) %>%
  summarise(Avg = round(mean(Percent), 1))

tile2 <- ggplot(tile2_data, aes(Gender, Avg, fill = Gender)) +
  geom_col(width = 0.55) +
  geom_text(aes(label = paste0(Avg, "%")),
            vjust = -0.2, size = 7, fontface = "bold") +
  
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  scale_fill_manual(values = c("Women" = col_always, "Men" = col_rarely)) +
  
  labs(
    title = "Women More Optimistic",
    subtitle = "Women report slightly higher optimism than men."
  ) +
  
  theme_minimal(base_size = 10) +
  theme(
    legend.position = "none",
    axis.title = element_blank(),
    axis.text.y = element_blank(),
    
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5,
                              margin = margin(t = 6, b = 2)),
    plot.subtitle = element_text(size = 10, hjust = 0.5,
                                 margin = margin(t = 0, b = 5)),
    
    plot.margin = margin(t = 5, r = 10, b = 5, l = 10)
  )

# TILE 3 — Rarely (Low pessimism)
tile3_data <- futout_clean %>%
  filter(Geography == "Canada", Gender == "Total", Indicators == "Rarely") %>%
  summarise(Avg = round(mean(Percent), 1))

tile3 <- ggplot(tile3_data, aes(1, 1)) +
  geom_text(aes(label = paste0(Avg, "%")),
            size = 18, color = col_rarely, fontface = "bold") +
  labs(
    title = "Low Level of Pessimism",
    subtitle = "Only a small share of Canadians feel pessimistic."
  ) +
  tile_theme

# TILE 4 — Sometimes
tile4_data <- futout_clean %>%
  filter(Geography == "Canada", Gender == "Total", Indicators == "Sometimes") %>%
  summarise(Avg = round(mean(Percent), 1))

tile4 <- ggplot(tile4_data, aes(1, 1)) +
  geom_text(aes(label = paste0(Avg, "%")),
            size = 18, color = col_sometimes, fontface = "bold") +
  labs(
    title = "Moderate Optimism Stable",
    subtitle = "Around 30% consistently feel moderately optimistic."
  ) +
  tile_theme

# TILE 5 — Top Provinces (Always)
tile5_data <- futout_clean %>%
  filter(Indicators == "Always", Gender == "Total", Geography != "Canada") %>%
  mutate(Geography = gsub("_", " ", Geography)) %>%
  group_by(Geography) %>%
  summarise(Avg = round(mean(Percent), 1)) %>%
  arrange(desc(Avg)) %>% slice(1:5)

tile5 <- ggplot(tile5_data, aes(reorder(Geography, Avg), Avg)) +
  geom_col(fill = col_always, width = 0.65) +
  geom_text(aes(label = Avg), hjust = -0.05,   # closer, less overhang
            size = 4, fontface = "bold") +
  coord_flip(clip = "off") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +  # LESS empty right space
  labs(
    title = "Top Provinces by Optimism",
    subtitle = "Quebec leads Canada in optimism."
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.4),
    plot.subtitle = element_text(size = 10, hjust = 0.4),
    axis.title = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    plot.margin = margin(10, 10, 10, 10)
  )

# TILE 6 — Sparkline (Trend)
tile6_data <- futout_clean %>%
  filter(Geography == "Canada", Gender == "Total", Indicators == "Always")

tile6 <- ggplot(tile6_data, aes(Date, Percent)) +
  geom_line(linewidth = 1.2, color = col_always) +
  geom_point(size = 2.5, color = col_always) +
  labs(
    title = "Optimism Over Time",
    subtitle = "Optimism fluctuates but remains high overall."
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5),
    axis.title = element_blank(),
    panel.grid.minor = element_blank()
  )

# FINAL LAYOUT
final_plot <- (tile1 | tile2 | tile3) /
  (tile4 | tile5 | tile6) +
  plot_annotation(
    title = "Future Outlook – Summary",
    subtitle = "Key national insights on optimism, gender differences, geography, and trends",
    theme = theme(
      plot.title = element_text(size = 24, face = "bold", hjust = 0),
      plot.subtitle = element_text(size = 14, hjust = 0)
    )
  )

print(final_plot)
