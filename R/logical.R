#' Logical generators
#'
#' A generator for logical vectors.
#'
#' @template len
#' @template frac_na
#'
#' @template generator
#' @export
logical_ <- \(len = 1L, frac_na = 0) {
  hedgehog::gen.element(c(TRUE, FALSE)) |>
    with_na(frac_na) |>
    vectorize(len)
}
