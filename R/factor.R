#' Factor generator
#'
#' A generator for factor vectors.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' factor_() |> show_example()
#' factor_(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
factor_ <- function(len = 1L, frac_na = 0) {
  hedgehog::gen.with(character_(len, frac_na), as.factor)
}
