#' Date generators
#'
#' A set of generators for date vectors.
#'
#' @template len
#' @template any_na
#' @template left
#' @template right
#'
#' @examples
#' date_() |> show_example()
#' date_bounded(
#'   left = as.Date("2020-01-01"),
#'   right = as.Date("2020-01-10")
#' ) |> show_example()
#' date_(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
date_ <- function(len = c(1L, 10L), any_na = FALSE) {
  date_bounded(min_date(), max_date(), len, any_na)
}

#' @rdname date_
#' @export
date_bounded <- function(left, right, len = c(1L, 10L), any_na = FALSE) {
  qc_gen(\(len2 = len)
    seq(left, right, by = "day") |>
      hedgehog::gen.element() |>
      replace_some_with(NA_real_, any_na) |>
      hedgehog::gen.with(as.Date) |>
      vectorize(len2)
  )
}

#' @rdname date_
#' @export
date_left_bounded <- function(left, len = c(1L, 10L), any_na = FALSE) {
  date_bounded(left, max_date(), len, any_na)
}

#' @rdname date_
#' @export
date_right_bounded <- function(right, len = c(1L, 10L), any_na = FALSE) {
  date_bounded(min_date(), right, len, any_na)
}

min_date <- function() {
  as.Date("1000-01-01")
}

max_date <- function() {
  as.Date("3000-01-01")
}
