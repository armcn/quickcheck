#' Convert a hedgehog generator to a quickcheck generator
#'
#' @param generator A `hedgehog.internal.gen` generator
#'
#' @examples
#' library(quickcheck)
#' library(testthat)
#'
#' is_even <-
#'   \(a) a %% 2L == 0L
#'
#' gen_powers_of_two <-
#'   hedgehog::gen.element(1:10) |> hedgehog::gen.with(\(a) 2 ^ a)
#'
#' for_all(
#'   a = from_hedgehog(gen_powers_of_two),
#'   property = \(a) is_even(a) |> expect_true()
#' )
#' @template generator
#' @export
from_hedgehog <- function(generator) {
  qc_gen(\() generator)
}

#' Show an example output of a generator
#'
#' @param generator A generator
#'
#' @examples
#' logical_() |> show_example()
#' @return An example output produced by the generator.
#' @export
show_example <- function(generator) {
  hedgehog::gen.example(generator())$root
}

#' @export
print.quickcheck_generator <- function (x, ...) {
  example <-
    hedgehog::gen.example(x())

  cat("Quickcheck generator:\n")
  cat("Example:\n")
  print(example$root)
  cat("Initial shrinks:\n")
  lapply(example$children(), \(a) print(a$root))
}

