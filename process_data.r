
library(tidyverse)

# Tidy the billboard data by pivoting weekly rankings into a longer format
billboard_longer <- billboard %>%
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    names_transform = list(week = as.integer),
    values_to = "rank",
    values_drop_na = TRUE
  )

# Get all 17 songs that hit the #1 spot
no1_songs <- billboard_longer %>%
  filter(rank == 1) %>%
  group_by(artist, track) %>%
  summarize(
    weeks_at_1 = n(),
    date_entered = min(date.entered),
    .groups = 'drop'
  )

# Clean up truncated song names for the y-axis labels
plot_data <- billboard_longer %>%
  inner_join(no1_songs, by = c("artist", "track")) %>%
  mutate(
    clean_track = case_when(
      track == "Independent Women Pa..." ~ "Independent Women (Part I)",
      track == "Come On Over Baby (A..." ~ "Come On Over Baby",
      track == "What A Girl Wants" ~ "What a Girl Wants",
      track == "Doesn't Really Matte..." ~ "Doesn't Really Matter",
      track == "Thank God I Found Yo..." ~ "Thank God I Found You",
      TRUE ~ track
    ),
    song_label = paste0(artist, " - '", clean_track, "'")
  )

# Order the songs chronologically by their entry date onto the chart
top_songs <- plot_data %>%
  mutate(song_label = fct_reorder(song_label, date_entered, .desc = TRUE))

write_rds(top_songs, file = "clean_data.rds")
