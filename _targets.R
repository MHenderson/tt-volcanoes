# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed. # nolint

# Set target options:
tar_option_set(
  packages = c("dplyr", "ggplot2", "ggrepel", "glue", "lubridate", "readr", "rnaturalearth", "sf", "tibble", "viridis"), # packages that your targets need to run
  format = "rds" # default storage format
  # Set other options as needed.
)

# tar_make_clustermq() configuration (okay to leave alone):
options(clustermq.scheduler = "multicore")

# tar_make_future() configuration (okay to leave alone):
# Install packages {{future}}, {{future.callr}}, and {{future.batchtools}} to allow use_targets() to configure tar_make_future() options.

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# source("other_functions.R") # Source other scripts as needed. # nolint

# Replace the target list below with your own:
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
    name = eruptions_plot,
    command = plot_eruptions(eruptions, world)
  ),
  tar_target(
    name = save_eruptions_plot,
    command = ggsave(plot = eruptions_plot, filename = "img/eruptions.png", bg = "white", width = 8, height = 8),
    format = "file"
  )
)
