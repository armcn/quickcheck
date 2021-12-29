#' Factor generator
#'
#' A generator for factor vectors.
#'
#' @template len
#' @template frac_na
#'
#' @template generator
#' @export
factor_ <- \(len = 1L, frac_na = 0) {
  character_(len, frac_na) |>
    hedgehog::gen.with(as.factor)
}
