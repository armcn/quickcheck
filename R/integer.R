#' Integer generators
#'
#' A set of generators for integer vectors.
#'
#' @template len
#' @template frac_na
#' @template big_int
#' @template left
#' @template right
#'
#' @examples
#' integer_() |> show_example()
#' integer_(big_int = TRUE) |> show_example()
#' integer_bounded(left = -5L, right = 5L) |> show_example()
#' integer_(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
integer_ <- function(len = 1L, frac_na = 0, big_int = FALSE) {
  integer_bounded(
    max_negative_integer(big_int),
    max_positive_integer(big_int),
    len,
    frac_na
  )
}

#' @rdname integer_
#' @export
integer_bounded <- function(left, right, len = 1L, frac_na = 0) {
  ensure_some_zeros <-
    \(a)
      if (overlaps_zero(left, right))
        hedgehog::gen.choice(a, 0L, prob = c(0.9, 0.1))

      else
        a

  qc_gen(\(len2 = len)
    hedgehog::gen.element(left:right) |>
      ensure_some_zeros() |>
      replace_frac_with(NA_integer_, frac_na) |>
      vectorize(len2)
  )
}

#' @rdname integer_
#' @export
integer_left_bounded <- function(left, len = 1L, frac_na = 0, big_int = FALSE) {
  integer_bounded(
    left,
    max_positive_integer(big_int),
    len,
    frac_na
  )
}

#' @rdname integer_
#' @export
integer_right_bounded <- function(right, len = 1L, frac_na = 0, big_int = FALSE) {
  integer_bounded(
    max_negative_integer(big_int),
    right,
    len,
    frac_na
  )
}

#' @rdname integer_
#' @export
integer_positive <- function(len = 1L, frac_na = 0, big_int = FALSE) {
  integer_left_bounded(1L, len, frac_na)
}

#' @rdname integer_
#' @export
integer_negative <- function(len = 1L, frac_na = 0, big_int = FALSE) {
  integer_right_bounded(-1L, len, frac_na)
}

max_positive_integer <- function(big_int = FALSE) {
  if (big_int)
    .Machine$integer.max

  else
    10000L
}

max_negative_integer <- function(big_int = FALSE) {
  -max_positive_integer(big_int)
}
