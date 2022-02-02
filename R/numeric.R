#' Numeric generators
#'
#' A set of generators for numeric vectors. Numeric vectors can be either
#' integer or double vectors.
#'
#' @template len
#' @template any_na
#' @template big_num
#' @template left
#' @template right
#'
#' @examples
#' numeric_() |> show_example()
#' numeric_(big_num = TRUE) |> show_example()
#' numeric_bounded(left = -5L, right = 5L) |> show_example()
#' numeric_(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
numeric_ <- function(len = c(1L, 10L),
                     any_na = FALSE,
                     big_num = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_(len2, any_na, big_int = big_num),
      double_(len2, any_na, big_dbl = big_num)
    )()
  )
}

#' @rdname numeric_
#' @export
numeric_bounded <- function(left,
                            right,
                            len = c(1L, 10L),
                            any_na = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_bounded(left, right, len2, any_na),
      double_bounded(left, right, len2, any_na)
    )()
  )
}

#' @rdname numeric_
#' @export
numeric_left_bounded <- function(left,
                                 len = c(1L, 10L),
                                 any_na = FALSE,
                                 big_num = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_left_bounded(
        left,
        len2,
        any_na,
        big_int = big_num
      ),
      double_left_bounded(
        left,
        len2,
        any_na,
        big_dbl = big_num
      )
    )()
  )
}

#' @rdname numeric_
#' @export
numeric_right_bounded <- function(right,
                                  len = c(1L, 10L),
                                  any_na = FALSE,
                                  big_num = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_right_bounded(
        right,
        len2,
        any_na,
        big_int = big_num
      ),
      double_right_bounded(
        right,
        len2,
        any_na,
        big_dbl = big_num
      )
    )()
  )
}

#' @rdname numeric_
#' @export
numeric_positive <- function(len = c(1L, 10L),
                             any_na = FALSE,
                             big_num = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_positive(len2, any_na, big_int = big_num),
      double_positive(len2, any_na, big_dbl = big_num)
    )()
  )
}

#' @rdname numeric_
#' @export
numeric_negative <- function(len = c(1L, 10L),
                             any_na = FALSE,
                             big_num = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_negative(len2, any_na, big_int = big_num),
      double_negative(len2, any_na, big_dbl = big_num)
    )()
  )
}
