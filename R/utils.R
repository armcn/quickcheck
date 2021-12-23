pipe <- function(...) {
  \(a)
    purrr::reduce(
      list(...),
      \(acc, f) f(acc),
      .init = a
    )
}


fail <- function(...) {
  stop(..., call. = FALSE)
}


as_generator <- function(a) {
  structure(a, class = "quickcheck_generator")
}
