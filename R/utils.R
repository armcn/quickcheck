overlaps_zero <- function(left, right) {
  isTRUE(left <= 0L && right >= 0L)
}

fail <- function(...) {
  stop(..., call. = FALSE)
}


