#' POSIXct generators
#'
#' A set of generators for POSIXct vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @examples
#' posixct_() |> show_example()
#' posixct_bounded(
#'   left = as.POSIXct("2020-01-01 00:00:00"),
#'   right = as.POSIXct("2021-01-01 00:00:00")
#' ) |> show_example()
#' posixct_(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
posixct_ <- function(len = 1L, frac_na = 0) {
  posixct_bounded(min_posixct(), max_posixct(), len, frac_na)
}

#' @rdname posixct_
#' @export
posixct_bounded <- function(left, right, len = 1L, frac_na = 0) {
  as_posixct <-
    purrr::partial(as.POSIXct, origin = "1970-01-01")

  qc_gen(\(len2 = len)
    hedgehog::gen.unif(as.double(left), as.double(right)) |>
      hedgehog::gen.with(as_posixct) |>
      replace_frac_with(NA_real_, frac_na) |>
      vectorize(len2)
  )
}

#' @rdname posixct_
#' @export
posixct_left_bounded <- function(left, len = 1L, frac_na = 0) {
  posixct_bounded(left, max_posixct(), len, frac_na)
}

#' @rdname posixct_
#' @export
posixct_right_bounded <- function(right, len = 1L, frac_na = 0) {
  posixct_bounded(min_posixct(), right, len, frac_na)
}

min_posixct <- function() {
  as.POSIXct("0000-01-01 00:00:00")
}

max_posixct <- function() {
  as.POSIXct("3000-01-01 00:00:00")
}
