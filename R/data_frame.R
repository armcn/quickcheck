#' Data frame generator
#'
#' Construct data frame generators in a similar way to
#' `base::data.frame`.
#'
#' @param ... A set of name-value pairs with the values
#' being vector generators.
#' @template rows
#'
#' @examples
#' data_frame_(a = integer_()) |> show_example()
#' data_frame_(a = integer_(), b = character_(), rows = 5L) |> show_example()
#' @template generator
#' @export
data_frame_ <- function(..., rows = c(1L, 10L)) {
  qc_gen(\()
    tibble_(..., rows = rows)() |>
      hedgehog::gen.with(as.data.frame)
  )
}

#' Random data frame generator
#'
#' @param ... A set of unnamed generators. The generated
#'   data frames will be build with random combinations of
#'   these generators.
#' @template rows
#' @template cols
#'
#' @examples
#' data_frame_of(logical_(), date_()) |> show_example()
#' data_frame_of(any_atomic(), rows = 10L, cols = 5L) |> show_example()
#' @template generator
#' @export
data_frame_of <- function(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  qc_gen(\()
    tibble_of(..., rows = rows, cols = cols)() |>
      hedgehog::gen.with(as.data.frame)
  )
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
#' @examples
#' tibble_(a = integer_()) |> show_example()
#' tibble_(a = integer_(), b = character_(), rows = 5L) |> show_example()
#' @template generator
#' @export
tibble_ <- function(..., rows = c(1L, 10L)) {
  qc_gen(\()
    purrr::map(list(...), \(a) a(len2 = rows)) |>
      hedgehog::gen.with(dplyr::as_tibble)
  )
}

#' Random tibble generator
#'
#' @param ... A set of unnamed generators. The generated
#'   tibbles will be build with random combinations of
#'   these generators.
#' @template rows
#' @template cols
#'
#' @examples
#' tibble_of(logical_(), date_()) |> show_example()
#' tibble_of(any_atomic(), rows = 10L, cols = 5L) |> show_example()
#' @template generator
#' @export
tibble_of <- function(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  qc_gen(\()
    list(...) |>
      purrr::map(\(a) a()) |>
      repeat_cols(size = cols) |>
      hedgehog::gen.with(purrr::partial(repeat_rows, rows = rows))
  )
}

repeat_cols <- function(generators, size) {
  as_tibble <-
    \(a) suppressMessages(
      dplyr::as_tibble(a, .name_repair = "unique")
    )

  sample_size <-
    if (length(size) == 1L)
      size

    else
      seq(size[1L], size[2L])

  expand_tibble_cols <-
    \(a) generators[
      sample(1:length(generators), a, TRUE)
    ]

  hedgehog::gen.element(sample_size) |>
    hedgehog::gen.and_then(expand_tibble_cols) |>
    hedgehog::gen.with(as_tibble)
}

repeat_rows <- function(df, rows) {
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
