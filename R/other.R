#' Randomly choose between generators
#'
#' @param ... Generators to choose from
#' @param prob A vector of probability weights for obtaining
#'   the elements of the vector being sampled.
#'
#' @template generator
#' @export
one_of <- \(..., prob = NULL) {
  hedgehog::gen.choice(..., prob = prob)
}

#' Generate the same value every time
#'
#' @param a Any R object
#'
#' @template generator
#' @export
constant <- \(a) {
  hedgehog::gen.choice(a)
}
