#' hms generators
#'
#' A set of generators for hms vectors.
#'
#' @template len
#' @template frac_na
#' @template left
#' @template right
#'
#' @template generator
#' @export
hms_ <- \(len = 1L, frac_na = 0) {
  hms_bounded(min_hms(), max_hms(), len, frac_na)
}

#' @rdname hms_
#' @export
hms_bounded <- \(left, right, len = 1L, frac_na = 0) {
  hedgehog::gen.unif(as.double(left), as.double(right)) |>
    hedgehog::gen.with(hms::as_hms) |>
    with_na(frac_na) |>
    vectorize(len)
}

#' @rdname hms_
#' @export
hms_left_bounded <- \(left, len = 1L, frac_na = 0) {
  hms_bounded(left, max_hms(), len, frac_na)
}

#' @rdname hms_
#' @export
hms_right_bounded <- \(right, len = 1L, frac_na = 0) {
  hms_bounded(min_hms(), right, len, frac_na)
}

min_hms <- \() {
  hms::as_hms("00:00:00")
}

max_hms <- \() {
  hms::as_hms("23:59:59")
}
