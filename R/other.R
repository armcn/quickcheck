#' Randomly choose between generators
#'
#' @param ... Generators to choose from
#' @param prob A vector of probability weights for obtaining
#'   the elements of the vector being sampled.
#'
#' @examples
#' one_of(integer_(), character_()) |> show_example()
#' one_of(constant(NULL), logical_(), prob = c(0.1, 0.9)) |> show_example()
#' @template generator
#' @export
one_of <- function(..., prob = NULL) {
  generators <-
    purrr::map(list(...), \(a) a())

  qc_gen(\()
    purrr::exec(
      purrr::partial(hedgehog::gen.choice, prob = prob),
      !!!generators
    )
  )
}

#' Generate the same value every time
#'
#' @param a Any R object
#'
#' @examples
#' constant(NULL) |> show_example()
#' @template generator
#' @export
constant <- function(a) {
  qc_gen(\(...)
    hedgehog::gen.choice(a)
  )
}

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
  example <- hedgehog::gen.example(x())
  cat("Hedgehog generator:\n")
  cat("Example:\n")
  print(example$root)
  cat("Initial shrinks:\n")
  lapply(example$children(), function(c) print(c$root))
}

