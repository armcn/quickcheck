#' Integer generators
#'
#' A set of generators for integer vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @examples
#' integer_() |> show_example()
#' integer_(len = 10L, frac_na = 0.5) |> show_example()
#' integer_bounded(left = -5L, right = 5L) |> show_example()
#'
#' @template generator
#' @export
integer_ <- \(len = 1L, frac_na = 0) {
  integer_bounded(
    max_negative_integer(),
    max_positive_integer(),
    len,
    frac_na
  )
}

#' @rdname integer_
#' @export
integer_bounded <- \(left, right, len = 1L, frac_na = 0) {
  ensure_some_zeros <-
    \(a)
      if (overlaps_zero(left, right))
        hedgehog::gen.choice(a, 1L, prob = c(0.9, 0.1))

      else
        a

  hedgehog::gen.element(left:right) |>
    ensure_some_zeros() |>
    with_na(frac_na) |>
    vectorize(len)
}

#' @rdname integer_
#' @export
integer_left_bounded <- \(left, len = 1L, frac_na = 0) {
  integer_bounded(
    left,
    max_positive_integer(),
    len,
    frac_na
  )
}

#' @rdname integer_
#' @export
integer_right_bounded <- \(right, len = 1L, frac_na = 0) {
  integer_bounded(
    max_negative_integer(),
    right,
    len,
    frac_na
  )
}

#' @rdname integer_
#' @export
integer_positive <- \(len = 1L, frac_na = 0) {
  integer_left_bounded(1L, len, frac_na)
}

#' @rdname integer_
#' @export
integer_negative <- \(len = 1L, frac_na = 0) {
  integer_right_bounded(-1L, len, frac_na)
}

max_positive_integer <- \() {
  .Machine$integer.max
}

max_negative_integer <- \() {
  -max_positive_integer()
}
