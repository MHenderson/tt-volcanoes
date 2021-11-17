library(here)
library(readr)

eruptions <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-12/eruptions.csv')

write_csv(eruptions, here("data-raw", "eruptions.csv"))
