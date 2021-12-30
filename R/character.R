#' Character generators
#'
#' A set of generators for character vectors.
#'
#' @template len
#' @template frac_na
#' @template frac_empty
#'
#' @examples
#' character_() |> show_example()
#' character_(len = 10L, frac_na = 0.5) |> show_example()
#' character_(len = 10L, frac_empty = 0.5) |> show_example()
#' @template generator
#' @export
character_ <- function(len = 1L, frac_na = 0, frac_empty = 0) {
  bytes_to_character(32L:126L) |>
    hedgehog::gen.element() |>
    with_empty(frac_empty) |>
    with_na(frac_na) |>
    vectorize(len)
}

bytes_to_character <- function(bytes) {
  as.raw(bytes) |>
    rawToChar() |>
    strsplit("") |>
    unlist()
}
