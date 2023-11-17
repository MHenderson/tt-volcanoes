# https://r-spatial.org/r/2018/10/25/ggplot2-sf.html
# https://yutani.rbind.io/post/geom-sf-text-and-geom-sf-label-are-coming/
library(dplyr)
library(ggplot2)
library(ggrepel)
library(glue)
library(here)
library(lubridate)
library(ragg)
library(readr)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(viridis)

eruptions <- read_csv(here("data-raw", "eruptions.csv"))

eruptions_to_plot <- eruptions %>%
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

world_sf <- ne_countries(
  scale = "medium",
  returnclass = "sf"
) %>%
  st_transform(crs = st_crs(3832))

countries_to_plot_sf <- world_sf %>%
  filter(admin != "Greenland") %>%
  filter(continent != "Antarctica")

agg_png(here("plots", "all_eruptions.png"), res = 320, height = 10, width = 24, units = "in")

p <- eruptions_sf %>%
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

print(p)

dev.off()
