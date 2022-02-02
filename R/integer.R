#' Integer generators
#'
#' A set of generators for integer vectors.
#'
#' @template len
#' @template any_na
#' @template big_int
#' @template left
#' @template right
#'
#' @examples
#' integer_() |> show_example()
#' integer_(big_int = TRUE) |> show_example()
#' integer_bounded(left = -5L, right = 5L) |> show_example()
#' integer_(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
integer_ <- function(len = c(1L, 10L),
                     any_na = FALSE,
                     big_int = FALSE) {
  integer_bounded(
    max_negative_integer(big_int),
    max_positive_integer(big_int),
    len,
    any_na
  )
}

#' @rdname integer_
#' @export
integer_bounded <- function(left,
                            right,
                            len = c(1L, 10L),
                            any_na = FALSE) {
  ensure_some_zeros <-
    \(a)
      if (overlaps_zero(left, right))
        hedgehog::gen.choice(a, 0L, prob = c(0.9, 0.1))

      else
        a

  qc_gen(\(len2 = len)
    hedgehog::gen.element(left:right) |>
      ensure_some_zeros() |>
      replace_some_with(NA_integer_, any_na) |>
      vectorize(len2)
  )
}

#' @rdname integer_
#' @export
integer_left_bounded <- function(left,
                                 len = c(1L, 10L),
                                 any_na = FALSE,
                                 big_int = FALSE) {
  integer_bounded(
    left,
    max_positive_integer(big_int),
    len,
    any_na
  )
}

#' @rdname integer_
#' @export
integer_right_bounded <- function(right,
                                  len = c(1L, 10L),
                                  any_na = FALSE,
                                  big_int = FALSE) {
  integer_bounded(
    max_negative_integer(big_int),
    right,
    len,
    any_na
  )
}

#' @rdname integer_
#' @export
integer_positive <- function(len = c(1L, 10L),
                             any_na = FALSE,
                             big_int = FALSE) {
  integer_left_bounded(1L, len, any_na)
}

#' @rdname integer_
#' @export
integer_negative <- function(len = c(1L, 10L),
                             any_na = FALSE,
                             big_int = FALSE) {
  integer_right_bounded(-1L, len, any_na)
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
