#' Data frame generators
#'
#' Construct data frame generators in a similar way to `base::data.frame`.
#'
#' @param ... A set of name-value pairs with the values being vector generators.
#' @template rows
#'
#' @examples
#' data_frame_(a = integer_()) |> show_example()
#' data_frame_(a = integer_(), b = character_(), rows = 5L) |> show_example()
#' @template generator
#' @export
data_frame_ <- function(..., rows = c(1L, 10L)) {
  assert_all_modifiable_length(...)

  tibble_(..., rows = rows) |>
    as_hedgehog() |>
    hedgehog::gen.with(as.data.frame) |>
    from_hedgehog()
}

#' Data frame generator with randomized columns
#'
#' @param ... A set of unnamed generators. The generated data frames will be
#' built with random combinations of these generators.
#' @template rows
#' @template cols
#'
#' @examples
#' data_frame_of(logical_(), date_()) |> show_example()
#' data_frame_of(any_atomic(), rows = 10L, cols = 5L) |> show_example()
#' @template generator
#' @export
data_frame_of <- function(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  assert_all_modifiable_length(...)

  tibble_of(..., rows = rows, cols = cols) |>
    as_hedgehog() |>
    hedgehog::gen.with(as.data.frame) |>
    from_hedgehog()
}
