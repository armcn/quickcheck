#' Double generators
#'
#' A set of generators for double vectors.
#'
#' @template len
#' @template frac_na
#' @template frac_nan
#' @template frac_inf
#' @template left
#' @template right
#'
#' @template generator
#' @export
double_ <- \(len = 1L,
             frac_na = 0,
             frac_nan = 0,
             frac_inf = 0) {
  double_bounded(
    max_negative_double(),
    max_positive_double(),
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_bounded <- \(left,
                    right,
                    len = 1L,
                    frac_na = 0,
                    frac_nan = 0,
                    frac_inf = 0) {
  ensure_some_zeros <-
    \(a)
      if (overlaps_zero(left, right))
        hedgehog::gen.choice(a, 0, prob = c(0.9, 0.1))

      else
        a

  hedgehog::gen.unif(left, right) |>
    ensure_some_zeros() |>
    with_na(frac_na) |>
    with_nan(frac_nan) |>
    with_inf(frac_inf) |>
    vectorize(len)
}

#' @rdname double_
#' @export
double_left_bounded <- \(left,
                         len = 1L,
                         frac_na = 0,
                         frac_nan = 0,
                         frac_inf = 0) {
  double_bounded(
    left,
    max_positive_double(),
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_right_bounded <- \(right,
                          len = 1L,
                          frac_na = 0,
                          frac_nan = 0,
                          frac_inf = 0) {
  double_bounded(
    max_negative_double(),
    right,
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_positive <- \(len = 1L,
                     frac_na = 0,
                     frac_nan = 0,
                     frac_inf = 0) {
  double_left_bounded(
    1L,
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_negative <- \(len = 1L,
                     frac_na = 0,
                     frac_nan = 0,
                     frac_inf = 0) {
  double_right_bounded(
    -1L,
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_fractional <- \(len = 1L,
                       frac_na = 0,
                       frac_nan = 0,
                       frac_inf = 0) {
  stats::runif(
    1e6,
    max_negative_double(),
    max_positive_double()
  ) |>
    { \(a) a[a %% 1L > 0.01] }() |>
    hedgehog::gen.element() |>
    with_na(frac_na) |>
    with_nan(frac_nan) |>
    with_inf(frac_inf) |>
    vectorize(len)
}

#' @rdname double_
#' @export
double_whole <- \(len = 1L,
                  frac_na = 0,
                  frac_nan = 0,
                  frac_inf = 0) {
  hedgehog::gen.map(
    round,
    double_(len, frac_na, frac_nan, frac_inf)
  )
}

max_positive_double <- \() {
  max_positive_integer()
}

max_negative_double <- \() {
  -max_positive_double()
}
