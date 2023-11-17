plot_eruptions <- function(X, world) {

  eruptions_to_plot <- X %>%
    filter(start_year == 1975) %>%
    filter(end_year == 1975) %>%
    filter(eruption_category == "Confirmed Eruption") %>%
    arrange(desc(vei)) %>%
    slice_head(n = 20) %>%
    mutate(
      start = make_date(start_year, start_month, start_day)
    ) %>%
    mutate(
      start_month = month(start, label = TRUE, abbr = FALSE),
      end_month = month(start, label = TRUE, abbr = FALSE)
    ) %>%
    mutate(
      label = case_when(
        start_day == end_day ~ glue("{start_day} {end_month}\n{volcano_name} (vei: {vei})"),
        TRUE ~ glue("{start_day} - {end_day} {end_month}\n{volcano_name} (vei: {vei})")
      )
    )

  eruptions_sf <- eruptions_to_plot %>%
    st_as_sf(
      coords = c("longitude", "latitude"),
      crs = 4326,
      agr = "constant"
    ) %>%
    st_transform(crs = st_crs(3832))

  countries_to_plot_sf <- world %>%
    filter(admin != "Greenland") %>%
    filter(continent != "Antarctica")

  eruptions_sf %>%
    ggplot() +
    geom_sf(data = countries_to_plot_sf, alpha = .5, size = .2, fill = "white") +
    geom_sf(aes(size = vei), alpha = .5) +
    geom_label_repel(
      data = eruptions_sf,
      aes(label = label, geometry = geometry),
      stat = "sf_coordinates",
      min.segment.length = Inf,
      colour = "blue",
      segment.colour = "blue"
    ) +
    scale_color_viridis() +
    theme_void()

}
