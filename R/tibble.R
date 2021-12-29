#' Tibble
#'
#' @param ... Dots
#' @param rows Rows
#'
#' @export
tibble_ <- \(..., rows = c(1L, 10L)) {
  equal_length(..., len = rows) |>
    hedgehog::gen.with(dplyr::as_tibble)
}

#' Tibble of
#'
#' @param ... Dots
#' @param rows Rows
#' @param cols Cols
#'
#' @export
tibble_of <- \(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  repeat_rows <-
    purrr::partial(repeat_rows, rows = rows)

  hedgehog::gen.with(
    repeat_cols(..., size = cols),
    repeat_rows
  )
}

repeat_cols <- \(..., size) {
  as_tibble <-
    \(a) suppressMessages(
      dplyr::as_tibble(a, .name_repair = "unique")
    )

  sample_size <-
    if (length(size) == 1L)
      size

    else
      seq(size[1L], size[2L])

  generators <-
    list(...)

  expand_tibble_cols <-
    \(a) generators[
      sample(1:length(generators), a, TRUE)
    ]

  hedgehog::gen.element(sample_size) |>
    hedgehog::gen.and_then(expand_tibble_cols) |>
    hedgehog::gen.with(as_tibble)
}

repeat_rows <- \(df, rows) {
  repeats <-
    if (length(rows) == 1L)
      rows

    else
      seq(rows[1L], rows[2L])

  purrr::reduce(
    rep(list(df), sample(repeats, 1L)),
    \(acc, a) dplyr::bind_rows(acc, a)
  )
}
