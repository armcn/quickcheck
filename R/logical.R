#' Logical generators
#'
#' A generator for logical vectors.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' logical_() |> show_example()
#' logical_(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
logical_ <- function(len = 1L, frac_na = 0) {
  hedgehog::gen.element(c(TRUE, FALSE)) |>
    with_na(frac_na) |>
    vectorize(len)
}
