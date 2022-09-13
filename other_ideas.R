library(lubridate)

eruptions %>%
  filter(!is.na(vei)) %>%
  mutate(
    start_date = make_date(start_year, start_month, start_day),
    end_date = make_date(end_year, end_month, end_day)
  ) %>%
  ggplot(aes(start_date, end_date)) +
    geom_point()

eruptions %>%
  filter(!is.na(vei)) %>%
 # filter(start_year > 1900) %>%
  mutate(
    start_date = make_date(start_year, start_month, start_day),
    end_date = make_date(end_year, end_month, end_day)
  ) %>%
  ggplot(aes(start_date, vei)) +
  geom_col(width = 5)
