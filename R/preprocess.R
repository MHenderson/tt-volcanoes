preprocess <- function(X) {

  X |>
    mutate(
      start = make_date(start_year, start_month, start_day)
    ) |>
    mutate(
      start_month = month(start, label = TRUE, abbr = FALSE),
        end_month = month(start, label = TRUE, abbr = FALSE)
    ) |>
    mutate(
      label = case_when(
        start_day == end_day ~ glue("{start_day} {end_month}\n{volcano_name} (vei: {vei})"),
                        TRUE ~ glue("{start_day} - {end_day} {end_month}\n{volcano_name} (vei: {vei})")
      )
    )

}
