#' Double generators
#'
#' A set of generators for double vectors.
#'
#' @template len
#' @template any_na
#' @template any_nan
#' @template any_inf
#' @template big_dbl
#' @template left
#' @template right
#'
#' @examples
#' double_() %>% show_example()
#' double_(big_dbl = TRUE) %>% show_example()
#' double_bounded(left = -5, right = 5) %>% show_example()
#' double_(len = 10L, any_na = TRUE) %>% show_example()
#' double_(len = 10L, any_nan = TRUE, any_inf = TRUE) %>% show_example()
#' @template generator
#' @export
double_ <- function(len = c(1L, 10L),
                    any_na = FALSE,
                    any_nan = FALSE,
                    any_inf = FALSE,
                    big_dbl = FALSE) {
  double_bounded(
    max_negative_double(big_dbl),
    max_positive_double(big_dbl),
    len,
    any_na,
    any_nan,
    any_inf
  )
}

#' @rdname double_
#' @export
double_bounded <- function(left,
                           right,
                           len = c(1L, 10L),
                           any_na = FALSE,
                           any_nan = FALSE,
                           any_inf = FALSE) {
  ensure_some_zeros <-
    function(a)
      if (overlaps_zero(left, right))
        hedgehog::gen.choice(a, 0, prob = c(0.9, 0.1))

      else
        a

  qc_gen(function(len2 = len)
    hedgehog::gen.unif(left, right) %>%
      ensure_some_zeros() %>%
      replace_some_with(NA_real_, any_na) %>%
      replace_some_with(NaN, any_nan) %>%
      replace_some_with(Inf, any_inf) %>%
      replace_some_with(-Inf, any_inf) %>%
      vectorize(len2)
  )
}

#' @rdname double_
#' @export
double_left_bounded <- function(left,
                                len = c(1L, 10L),
                                any_na = FALSE,
                                any_nan = FALSE,
                                any_inf = FALSE,
                                big_dbl = FALSE) {
  double_bounded(
    left,
    max_positive_double(big_dbl),
    len,
    any_na,
    any_nan,
    any_inf
  )
}

#' @rdname double_
#' @export
double_right_bounded <- function(right,
                                 len = c(1L, 10L),
                                 any_na = FALSE,
                                 any_nan = FALSE,
                                 any_inf = FALSE,
                                 big_dbl = FALSE) {
  double_bounded(
    max_negative_double(big_dbl),
    right,
    len,
    any_na,
    any_nan,
    any_inf
  )
}

#' @rdname double_
#' @export
double_positive <- function(len = c(1L, 10L),
                            any_na = FALSE,
                            any_nan = FALSE,
                            any_inf = FALSE,
                            big_dbl = FALSE) {
  double_left_bounded(
    min_positive_double(),
    len,
    any_na,
    any_nan,
    any_inf,
    big_dbl
  )
}

#' @rdname double_
#' @export
double_negative <- function(len = c(1L, 10L),
                            any_na = FALSE,
                            any_nan = FALSE,
                            any_inf = FALSE,
                            big_dbl = FALSE) {
  double_right_bounded(
    min_negative_double(),
    len,
    any_na,
    any_nan,
    any_inf,
    big_dbl
  )
}

#' @rdname double_
#' @export
double_fractional <- function(len = c(1L, 10L),
                              any_na = FALSE,
                              any_nan = FALSE,
                              any_inf = FALSE,
                              big_dbl = FALSE) {
  keep_fractional <-
    function(a) a[a %% 1L > 0.0001]

  qc_gen(function(len2 = len)
    stats::runif(
      1e6,
      max_negative_double(big_dbl),
      max_positive_double(big_dbl)
    ) %>%
      keep_fractional() %>%
      hedgehog::gen.element() %>%
      replace_some_with(NA_real_, any_na) %>%
      replace_some_with(NaN, any_nan) %>%
      replace_some_with(Inf, any_inf) %>%
      replace_some_with(-Inf, any_inf) %>%
      vectorize(len2)
  )
}

#' @rdname double_
#' @export
double_whole <- function(len = c(1L, 10L),
                         any_na = FALSE,
                         any_nan = FALSE,
                         any_inf = FALSE,
                         big_dbl = FALSE) {
  qc_gen(function(len2 = len)
    double_(len2, any_na, any_nan, any_inf, big_dbl) %>%
      as_hedgehog() %>%
      hedgehog::gen.with(round)
  )
}

max_positive_double <- function(big_dbl = FALSE) {
  if (big_dbl)
    .Machine$double.xmax / 2

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
