#' Numeric generators
#'
#' A set of generators for numeric vectors. Numeric vectors
#' can be either integer or double vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @template generator
#' @export
numeric_ <- \(len = 1L, frac_na = 0) {
  one_of(integer_(len, frac_na), double_(len, frac_na))
}

#' @rdname numeric_
#' @export
numeric_bounded <- \(left, right, len = 1L, frac_na = 0) {
  one_of(
    integer_bounded(left, right, len, frac_na),
    double_bounded(left, right, len, frac_na)
  )
}

#' @rdname numeric_
#' @export
numeric_left_bounded <- \(left, len = 1L, frac_na = 0) {
  one_of(
    integer_left_bounded(left, len, frac_na),
    double_left_bounded(left, len, frac_na)
  )
}

#' @rdname numeric_
#' @export
numeric_right_bounded <- \(right, len = 1L, frac_na = 0) {
  one_of(
    integer_right_bounded(right, len, frac_na),
    double_right_bounded(right, len, frac_na)
  )
}

#' @rdname numeric_
#' @export
numeric_positive <- \(len = 1L, frac_na = 0) {
  one_of(
    integer_positive(len, frac_na),
    double_positive(len, frac_na)
  )
}

#' @rdname numeric_
#' @export
numeric_negative <- \(len = 1L, frac_na = 0) {
  one_of(
    integer_negative(len, frac_na),
    double_negative(len, frac_na)
  )
}
