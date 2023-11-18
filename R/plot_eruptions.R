plot_eruptions <- function(X, world) {

  eruptions_sf <- X |>
    filter(start_year == 1975) |>
    filter(end_year == 1975) |>
    filter(eruption_category == "Confirmed Eruption") |>
    arrange(desc(vei)) |>
    slice_head(n = 5)

  countries_to_plot_sf <- world |>
    filter(admin != "Greenland") |>
    filter(continent != "Antarctica")

  eruptions_sf |>
    ggplot() +
    geom_sf(data = countries_to_plot_sf, alpha = .5, size = .2, fill = "white") +
    geom_sf(aes(size = vei), alpha = .5) +
    geom_label_repel(
                    data = eruptions_sf,
                 mapping = aes(label = label, geometry = geometry),
                    stat = "sf_coordinates",
                  colour = "blue",
          segment.colour = "blue"
    ) +
    scale_color_viridis() +
    theme_void() +
    theme(legend.position = "bottom")

}
