eruptions %>%
  ggplot(aes(latitude)) +
    geom_histogram()

eruptions %>%
  ggplot(aes(longitude)) +
    geom_histogram()

volcano %>%
  ggplot(aes(elevation)) +
    geom_histogram()
