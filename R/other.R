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
  hedgehog::gen.choice(..., prob = prob)
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
  hedgehog::gen.choice(a)
}

#' Show an example output of a generator
#'
#' @param generator Generator
#'
#' @export
show_example <- function(generator) {
  generator |>
    hedgehog::gen.example() |>
    purrr::pluck("root")
}
