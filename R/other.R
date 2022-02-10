#' Convert a hedgehog generator to a quickcheck generator
#'
#' @param generator A `hedgehog.internal.gen` object.
#'
#' @examples
#' is_even <-
#'   \(a) a %% 2L == 0L
#'
#' gen_powers_of_two <-
#'   hedgehog::gen.element(1:10) |> hedgehog::gen.with(\(a) 2 ^ a)
#'
#' for_all(
#'   a = from_hedgehog(gen_powers_of_two),
#'   property = \(a) is_even(a) |> testthat::expect_true()
#' )
#' @template generator
#' @export
from_hedgehog <- function(generator) {
  qc_gen(\() generator)
}

#' Convert a quickcheck generator to a hedgehog generator
#'
#' @template param_generator
#'
#' @examples
#' is_even <-
#'   \(a) a %% 2L == 0L

#' gen_powers_of_two <-
#'   integer_bounded(1L, 10L, len = 1L) |>
#'     as_hedgehog() |>
#'     hedgehog::gen.with(\(a) 2 ^ a)

#' for_all(
#'   a = from_hedgehog(gen_powers_of_two),
#'   property = \(a) is_even(a) |> testthat::expect_true()
#' )
#' @template generator
#' @export
as_hedgehog <- function(generator) {
  generator()
}

#' Show an example output of a generator
#'
#' @template param_generator
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
  purrr::walk(example$children(), \(a) print(a$root))
}

