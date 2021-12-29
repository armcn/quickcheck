#' Data frame generator
#'
#' Construct data frame generators in a similar way to
#' `base::data.frame`.
#'
#' @param ... A set of name-value pairs with the values
#' being vector generators.
#' @template rows
#'
#' @template generator
#' @export
data_frame_ <- \(..., rows = c(1L, 10L)) {
  tibble_(..., rows = rows) |>
    hedgehog::gen.with(as.data.frame)
}

#' Random data frame generator
#'
#' @param ... A set of unnamed generators. The generated
#'   data frames will be build with random combinations of
#'   these generators.
#' @template rows
#' @template cols
#'
#' @template generator
#' @export
data_frame_of <- \(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  tibble_of(..., rows = rows, cols = cols) |>
    hedgehog::gen.with(as.data.frame)
}

#' Tibble generator
#'
#' Construct tibble generators in a similar way to
#' `dplyr::tibble`.
#'
#' @param ... A set of name-value pairs with the values
#' being vector generators.
#' @template rows
#'
#' @template generator
#' @export
tibble_ <- \(..., rows = c(1L, 10L)) {
  equal_length(..., len = rows) |>
    hedgehog::gen.with(dplyr::as_tibble)
}

#' Random tibble generator
#'
#' @param ... A set of unnamed generators. The generated
#'   tibbles will be build with random combinations of
#'   these generators.
#' @template rows
#' @template cols
#'
#' @template generator
#' @export
tibble_of <- \(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  hedgehog::gen.with(
    repeat_cols(..., size = cols),
    purrr::partial(repeat_rows, rows = rows)
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
