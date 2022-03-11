#' POSIXct generators
#'
#' A set of generators for POSIXct vectors.
#'
#' @template len
#' @template any_na
#' @template left
#' @template right
#'
#' @examples
#' posixct_() %>% show_example()
#' posixct_bounded(
#'   left = as.POSIXct("2020-01-01 00:00:00"),
#'   right = as.POSIXct("2021-01-01 00:00:00")
#' ) %>% show_example()
#' posixct_(len = 10L, any_na = TRUE) %>% show_example()
#' @template generator
#' @export
posixct_ <- function(len = c(1L, 10L), any_na = FALSE) {
  posixct_bounded(min_posixct(), max_posixct(), len, any_na)
}

#' @rdname posixct_
#' @export
posixct_bounded <- function(left, right, len = c(1L, 10L), any_na = FALSE) {
  as_posixct <-
    purrr::partial(as.POSIXct, origin = "1970-01-01")

  qc_gen(function(len2 = len)
    hedgehog::gen.unif(as.double(left), as.double(right)) %>%
      replace_some_with(NA_real_, any_na) %>%
      hedgehog::gen.with(as_posixct) %>%
      vectorize(len2)
  )
}

#' @rdname posixct_
#' @export
posixct_left_bounded <- function(left, len = c(1L, 10L), any_na = FALSE) {
  posixct_bounded(left, max_posixct(), len, any_na)
}

#' @rdname posixct_
#' @export
posixct_right_bounded <- function(right, len = c(1L, 10L), any_na = FALSE) {
  posixct_bounded(min_posixct(), right, len, any_na)
}

min_posixct <- function() {
  as.POSIXct("0000-01-01 00:00:00")
}

max_posixct <- function() {
  as.POSIXct("3000-01-01 00:00:00")
}
