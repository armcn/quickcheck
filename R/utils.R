overlaps_zero <- function(left, right) {
  isTRUE(left <= 0L && right >= 0L)
}

fail <- function(...) {
  stop(..., call. = FALSE)
}

qc_gen <- function(a) {
  structure(a, class = "quickcheck_generator")
}
