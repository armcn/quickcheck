#' POSIXct generators
#'
#' A set of generators for POSIXct vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @template generator
#' @export
posixct_ <- \(len = 1L, frac_na = 0) {
  posixct_bounded(
    min_posixct(),
    max_posixct(),
    len,
    frac_na
  )
}

#' @rdname posixct_
#' @export
posixct_bounded <- \(left, right, len = 1L, frac_na = 0) {
  as_posixct <-
    purrr::partial(as.POSIXct, origin = "1970-01-01")

  hedgehog::gen.unif(as.double(left), as.double(right)) |>
    hedgehog::gen.with(as_posixct) |>
    with_na(frac_na) |>
    vectorize(len)
}

#' @rdname posixct_
#' @export
posixct_left_bounded <- \(left, len = 1L, frac_na = 0) {
  posixct_bounded(left, max_posixct(), len, frac_na)
}

#' @rdname posixct_
#' @export
posixct_right_bounded <- \(right, len = 1L, frac_na = 0) {
  posixct_bounded(min_posixct(), right, len, frac_na)
}

min_posixct <- \() {
  as.POSIXct("0000-01-01 00:00:00")
}

max_posixct <- \() {
  as.POSIXct("3000-01-01 00:00:00")
}
