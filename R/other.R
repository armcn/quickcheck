#' Show an example output of a generator
#'
#' @param generator Generator
#'
#' @export
show_example <- function(generator) {
  generator() |>
    hedgehog::gen.example() |>
    purrr::pluck("root")
}

#' @export
print.quickcheck_generator <- function (x, ...) {
  example <-
    hedgehog::gen.example(x())

  cat("Hedgehog generator:\n")
  cat("Example:\n")
  print(example$root)
  cat("Initial shrinks:\n")
  lapply(example$children(), \(a) print(a$root))
}

