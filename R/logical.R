#' Logical generator
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
  qc_gen(\(len2 = len)
    hedgehog::gen.element(c(TRUE, FALSE)) |>
      replace_frac_with(NA, frac_na) |>
      vectorize(len2)
  )
}
