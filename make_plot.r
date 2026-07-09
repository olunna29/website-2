library(tidyverse)

x <- read_rds("clean_data.rds")

billboard_plot <- ggplot(x, aes(x = week, y = song_label, fill = rank)) +
  geom_tile(color = "#0f172a", linewidth = 0.6) +
  # Using viridis magma palette with reversed transformation so rank 1 (Peak) is bright yellow/gold
  scale_fill_viridis_c(
    option = "magma",
    trans = "reverse",
    breaks = c(1, 10, 25, 50, 75, 100),
    labels = c("1 (Peak)", "10", "25", "50", "75", "100")
  ) +
  scale_x_continuous(breaks = seq(0, 70, by = 5), expand = c(0, 0)) +
  labs(
    title = "Billboard Hot 100: Trajectories of the #1 Hits of 2000",
    subtitle = "Chronological visualization of each song's weekly rank, from entry to exit",
    x = "Weeks on the Chart",
    y = NULL,
    fill = "Chart Rank"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "#0f172a", color = NA),
    panel.background = element_rect(fill = "#0f172a", color = NA),
    text = element_text(color = "#f1f5f9"),
    plot.title = element_text(size = 16, face = "bold", margin = margin(b = 6), color = "#f8fafc"),
    plot.subtitle = element_text(size = 11, color = "#94a3b8", margin = margin(b = 15)),
    axis.text.x = element_text(color = "#cbd5e1", size = 10),
    axis.text.y = element_text(color = "#f1f5f9", size = 9, face = "bold"),
    axis.title.x = element_text(color = "#94a3b8", size = 10, face = "bold", margin = margin(t = 10)),
    panel.grid = element_blank(),
    legend.position = "right",
    legend.text = element_text(size = 9, color = "#cbd5e1"),
    legend.title = element_text(size = 10, face = "bold", color = "#f8fafc"),
    plot.margin = margin(20, 20, 20, 20)
  )

  ggsave("billboard.png", billboard_plot)
