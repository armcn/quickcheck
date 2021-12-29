#' Date generators
#'
#' A set of generators for date vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @template generator
#' @export
date_ <- \(len = 1L, frac_na = 0) {
  date_bounded(min_date(), max_date(), len, frac_na)
}

#' @rdname date_
#' @export
date_bounded <- \(left, right, len = 1L, frac_na = 0) {
  seq(left, right, by = "day") |>
    hedgehog::gen.element() |>
    with_na(frac_na) |>
    vectorize(len)
}

#' @rdname date_
#' @export
date_left_bounded <- \(left, len = 1L, frac_na = 0) {
  date_bounded(left, max_date(), len, frac_na)
}

#' @rdname date_
#' @export
date_right_bounded <- \(right, len = 1L, frac_na = 0) {
  date_bounded(min_date(), right, len, frac_na)
}

min_date <- \() {
  as.Date("0000-01-01")
}

max_date <- \() {
  as.Date("3000-01-01")
}
