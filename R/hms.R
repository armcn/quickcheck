#' hms generators
#'
#' A set of generators for hms vectors.
#'
#' @template len
#' @template any_na
#' @template left
#' @template right
#'
#' @examples
#' hms_() %>% show_example()
#' hms_bounded(
#'   left = hms::as_hms("00:00:00"),
#'   right = hms::as_hms("12:00:00")
#' ) %>% show_example()
#' hms_(len = 10L, any_na = TRUE) %>% show_example()
#' @template generator
#' @export
hms_ <- function(len = c(1L, 10L), any_na = FALSE) {
  hms_bounded(min_hms(), max_hms(), len, any_na)
}

#' @rdname hms_
#' @export
hms_bounded <- function(left, right, len = c(1L, 10L), any_na = FALSE) {
  qc_gen(function(len2 = len)
    hedgehog::gen.unif(as.double(left), as.double(right)) %>%
      replace_some_with(NA_real_, any_na) %>%
      hedgehog::gen.with(hms::as_hms) %>%
      vectorize(len2)
  )
}

#' @rdname hms_
#' @export
hms_left_bounded <- function(left, len = c(1L, 10L), any_na = FALSE) {
  hms_bounded(left, max_hms(), len, any_na)
}

#' @rdname hms_
#' @export
hms_right_bounded <- function(right, len = c(1L, 10L), any_na = FALSE) {
  hms_bounded(min_hms(), right, len, any_na)
}

min_hms <- function() {
  hms::as_hms("00:00:00")
}

max_hms <- function() {
  hms::as_hms("23:59:59")
}
