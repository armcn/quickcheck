#' Numeric generators
#'
#' A set of generators for numeric vectors. Numeric vectors
#' can be either integer or double vectors.
#'
#' @template len
#' @template frac_na
#' @template big_num
#' @template left
#' @template right
#'
#' @examples
#' numeric_() |> show_example()
#' numeric_(big_num = TRUE) |> show_example()
#' numeric_bounded(left = -5L, right = 5L) |> show_example()
#' numeric_(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
numeric_ <- function(len = 1L, frac_na = 0, big_num = FALSE) {
  one_of(
    integer_(len, frac_na, big_int = big_num),
    double_(len, frac_na, big_dbl = big_num)
  )
}

#' @rdname numeric_
#' @export
numeric_bounded <- function(left, right, len = 1L, frac_na = 0) {
  one_of(
    integer_bounded(left, right, len, frac_na),
    double_bounded(left, right, len, frac_na)
  )
}

#' @rdname numeric_
#' @export
numeric_left_bounded <- function(left, len = 1L, frac_na = 0, big_num = FALSE) {
  one_of(
    integer_left_bounded(
      left,
      len,
      frac_na,
      big_int = big_num
    ),
    double_left_bounded(
      left,
      len,
      frac_na,
      big_dbl = big_num
    )
  )
}

#' @rdname numeric_
#' @export
numeric_right_bounded <- function(right, len = 1L, frac_na = 0, big_num = FALSE) {
  one_of(
    integer_right_bounded(
      right,
      len,
      frac_na,
      big_int = big_num
    ),
    double_right_bounded(
      right,
      len,
      frac_na,
      big_dbl = big_num
    )
  )
}

#' @rdname numeric_
#' @export
numeric_positive <- function(len = 1L, frac_na = 0, big_num = FALSE) {
  one_of(
    integer_positive(len, frac_na, big_int = big_num),
    double_positive(len, frac_na, big_dbl = big_num)
  )
}

#' @rdname numeric_
#' @export
numeric_negative <- function(len = 1L, frac_na = 0, big_num = FALSE) {
  one_of(
    integer_negative(len, frac_na, big_int = big_num),
    double_negative(len, frac_na, big_dbl = big_num)
  )
}
