#' Date generators
#'
#' A set of generators for date vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @examples
#' date_() |> show_example()
#' date_bounded(
#'   left = as.Date("2020-01-01"),
#'   right = as.Date("2020-01-10")
#' ) |> show_example()
#' date_(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
date_ <- function(len = 1L, frac_na = 0) {
  date_bounded(min_date(), max_date(), len, frac_na)
}

#' @rdname date_
#' @export
date_bounded <- function(left, right, len = 1L, frac_na = 0) {
  qc_gen(\(len2 = len)
    seq(left, right, by = "day") |>
      hedgehog::gen.element() |>
      replace_frac_with(NA_real_, frac_na) |>
      vectorize(len2)
  )
}

#' @rdname date_
#' @export
date_left_bounded <- function(left, len = 1L, frac_na = 0) {
  date_bounded(left, max_date(), len, frac_na)
}

#' @rdname date_
#' @export
date_right_bounded <- function(right, len = 1L, frac_na = 0) {
  date_bounded(min_date(), right, len, frac_na)
}

min_date <- function() {
  as.Date("1000-01-01")
}

max_date <- function() {
  as.Date("3000-01-01")
}
