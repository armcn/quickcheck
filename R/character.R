#' Character generators
#'
#' A set of generators for character vectors.
#'
#' @template len
#' @template frac_na
#' @template frac_empty
#'
#' @template generator
#' @export
character_ <- \(len = 1L, frac_empty = 0, frac_na = 0) {
  bytes_to_character(32L:126L) |>
    hedgehog::gen.element() |>
    with_empty(frac_empty) |>
    with_na(frac_na) |>
    vectorize(len)
}

bytes_to_character <- \(bytes) {
  as.raw(bytes) |>
    rawToChar() |>
    strsplit("") |>
    unlist()
}
