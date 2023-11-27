plot_eruptions <- function(X, world) {

  eruptions_sf <- X |>
    filter(eruption_category == "Confirmed Eruption") |>
    arrange(desc(vei)) |>
    slice_head(n = 100)

  countries_to_plot_sf <- world |>
    filter(admin != "Greenland") |>
    filter(continent != "Antarctica")

  eruptions_sf |>
    ggplot() +
    geom_sf(data = countries_to_plot_sf, alpha = .5, size = .2, fill = "white") +
    geom_sf(aes(colour = vei, size = vei), alpha = 0.5) +
    coord_sf(xlim = c(-5500000, 15500000)) +
    theme_void() +
    theme(legend.position = "bottom") +
    scale_colour_gradient(trans = "reverse") +
    guides(size = "none")

}
