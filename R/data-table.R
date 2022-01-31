#' data.table generators
#'
#' Construct data.table generators in a similar way to `data.table::data.table`.
#'
#' @param ... A set of name-value pairs with the values being vector generators.
#' @template rows
#'
#' @examples
#' data.table_(a = integer_()) |> show_example()
#' data.table_(a = integer_(), b = character_(), rows = 5L) |> show_example()
#' @template generator
#' @export
data.table_ <- function(..., rows = c(1L, 10L)) {
  tibble_(..., rows = rows) |>
    as_hedgehog() |>
    hedgehog::gen.with(data.table::as.data.table) |>
    from_hedgehog()
}

#' Random data.table generator
#'
#' @param ... A set of unnamed generators. The generated data.tables will be
#' built with random combinations of these generators.
#' @template rows
#' @template cols
#'
#' @examples
#' data.table_of(logical_(), date_()) |> show_example()
#' data.table_of(any_atomic(), rows = 10L, cols = 5L) |> show_example()
#' @template generator
#' @export
data.table_of <- function(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  tibble_of(..., rows = rows, cols = cols) |>
    as_hedgehog() |>
    hedgehog::gen.with(data.table::as.data.table) |>
    from_hedgehog()
}
