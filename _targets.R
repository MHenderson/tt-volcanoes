library(targets)

tar_option_set(
  packages = c("dplyr", "ggplot2", "ggrepel", "glue", "lubridate", "readr", "rnaturalearth", "sf", "tibble", "viridis"),
  format = "rds"
)

options(clustermq.scheduler = "multicore")

tar_source()

list(
  tar_target(
       name = eruptions,
    command = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-12/eruptions.csv')
  ),
  tar_target(
       name = volcano,
    command = read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-12/volcano.csv')
  ),
  tar_target(
        name = world,
    command = ne_countries(scale = "medium", returnclass = "sf")
  ),
  tar_target(
       name = eruptions_sf,
    command = eruptions |>
      st_as_sf(
        coords = c("longitude", "latitude"),
           crs = 4326,
           agr = "constant"
      ) |>
      st_transform(crs = st_crs(3832))
  ),
  tar_target(
       name = eruptions_sf_pp,
    command = preprocess(eruptions_sf)
  ),
  tar_target(
       name = eruptions_plot,
    command = plot_eruptions(eruptions_sf_pp, world)
  ),
  tar_target(
       name = save_eruptions_plot,
    command = ggsave(
          plot = eruptions_plot,
      filename = "img/eruptions.png",
            bg = "white",
         width = 8,
        height = 8
    ),
     format = "file"
  )
)
