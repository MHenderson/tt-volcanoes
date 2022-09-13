# https://datavizpyr.com/dumbbell-plot-in-r-with-ggplot2/
# https://www.r-graph-gallery.com/267-reorder-a-variable-in-ggplot2.html

X <- eruptions %>%
  filter(start_year > 1975) %>%
  #filter(end_year == 1975) %>%
  filter(eruption_category == "Confirmed Eruption") %>%
  slice_head(n = 100) %>%
  mutate(
    start = make_date(start_year, start_month, start_day),
    end = make_date(end_year, end_month, end_day),
    diff = end - start
  ) %>%
  arrange(diff, start) %>%
  mutate(
    volcano_name = factor(volcano_name, levels = unique(volcano_name))
  )


X %>%
  pivot_longer(names_to = "event", values_to = "date", cols = start:end) %>%
  ggplot(aes(x = date, y = volcano_name)) +
    geom_line(aes(group = eruption_number)) +
    geom_point(aes(color = event), size = 4) +
    theme(legend.position = "top")
