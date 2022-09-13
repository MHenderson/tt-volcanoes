library(here)
library(readr)

volcano <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-12/volcano.csv')

write_csv(volcano, here("data-raw", "volcano.csv"))
