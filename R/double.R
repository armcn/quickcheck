#' Double generators
#'
#' A set of generators for double vectors.
#'
#' @template len
#' @template frac_na
#' @template frac_nan
#' @template frac_inf
#' @template big_dbl
#' @template left
#' @template right
#'
#' @examples
#' double_() |> show_example()
#' double_(big_dbl = TRUE) |> show_example()
#' double_bounded(left = -5, right = 5) |> show_example()
#' double_(len = 10L, frac_na = 0.5) |> show_example()
#' double_(len = 10L, frac_nan = 0.2, frac_inf = 0.2) |> show_example()
#' @template generator
#' @export
double_ <- function(len = 1L,
                    frac_na = 0,
                    frac_nan = 0,
                    frac_inf = 0,
                    big_dbl = FALSE) {
  double_bounded(
    max_negative_double(big_dbl),
    max_positive_double(big_dbl),
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_bounded <- function(left,
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
double_left_bounded <- function(left,
                                len = 1L,
                                frac_na = 0,
                                frac_nan = 0,
                                frac_inf = 0,
                                big_dbl = FALSE) {
  double_bounded(
    left,
    max_positive_double(big_dbl),
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_right_bounded <- function(right,
                                 len = 1L,
                                 frac_na = 0,
                                 frac_nan = 0,
                                 frac_inf = 0,
                                 big_dbl = FALSE) {
  double_bounded(
    max_negative_double(big_dbl),
    right,
    len,
    frac_na,
    frac_nan,
    frac_inf
  )
}

#' @rdname double_
#' @export
double_positive <- function(len = 1L,
                            frac_na = 0,
                            frac_nan = 0,
                            frac_inf = 0,
                            big_dbl = FALSE) {
  double_left_bounded(
    min_positive_double(),
    len,
    frac_na,
    frac_nan,
    frac_inf,
    big_dbl
  )
}

#' @rdname double_
#' @export
double_negative <- function(len = 1L,
                            frac_na = 0,
                            frac_nan = 0,
                            frac_inf = 0,
                            big_dbl = FALSE) {
  double_right_bounded(
    min_negative_double(),
    len,
    frac_na,
    frac_nan,
    frac_inf,
    big_dbl
  )
}

#' @rdname double_
#' @export
double_fractional <- function(len = 1L,
                              frac_na = 0,
                              frac_nan = 0,
                              frac_inf = 0,
                              big_dbl = FALSE) {
  keep_fractional <-
    \(a) a[a %% 1L > 0.0001]

  stats::runif(
    1e6,
    max_negative_double(big_dbl),
    max_positive_double(big_dbl)
  ) |>
    keep_fractional() |>
    hedgehog::gen.element() |>
    with_na(frac_na) |>
    with_nan(frac_nan) |>
    with_inf(frac_inf) |>
    vectorize(len)
}

#' @rdname double_
#' @export
double_whole <- function(len = 1L,
                         frac_na = 0,
                         frac_nan = 0,
                         frac_inf = 0,
                         big_dbl = FALSE) {
  hedgehog::gen.with(
    double_(
      len,
      frac_na,
      frac_nan,
      frac_inf,
      big_dbl
    ),
    round
  )
}

max_positive_double <- function(big_dbl = FALSE) {
  if (big_dbl)
    .Machine$double.xmax

  else
    1e9
}

max_negative_double <- function(big_dbl = FALSE) {
  -max_positive_double(big_dbl)
}

min_positive_double <- function() {
  .Machine$double.xmin
}

min_negative_double <- function() {
  -min_positive_double()
}
