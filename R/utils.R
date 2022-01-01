qc_gen <- function(a) {
  structure(a, class = "quickcheck_generator")
}

sample_vec <- function(a, n = 1L) {
  if (dplyr::n_distinct(a) == 1L)
    a[[1L]]

  else
    sample(a, size = n, replace = TRUE)
}

eval_functions <- function(...) {
  purrr::map(list(...), \(f) f())
}

overlaps_zero <- function(left, right) {
  isTRUE(left <= 0L && right >= 0L)
}

fail <- function(...) {
  stop(..., call. = FALSE)
}
