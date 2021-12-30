#' Test properties of a function
#'
#' @param ... Dots
#' @param property A function which takes a value from from
#'   the generator and calls an expectation on it.
#' @param tests The number of tests to run.
#' @param size The maximum length of the generators.
#' @param shrinks The maximum number of shrinks to run when
#'   shrinking a value to find the smallest counterexample.
#' @param discards The maximum number of discards to permit
#'   when running the property.
#'
#' @examples
#' library(testthat)
#' for_all(
#'   a = numeric_(),
#'   b = numeric_(),
#'   property = \(a, b) expect_equal(a + b, b + a)
#' )
#' for_all(
#'   x = any_vector(),
#'   property = \(x) rev(x) |> rev() |> expect_equal(x)
#' )
#' @return TRUE if tests pass
#' @export
for_all <- function(...,
                    property,
                    tests = get_tests(),
                    size = get_size(),
                    shrinks = get_shrinks(),
                    discards = get_discards()) {
  list(...) |>
    assert_generators_named() |>
    hedgehog::forall(
      property = property,
      tests = tests,
      size.limit = size,
      shrink.limit = shrinks,
      discard.limit = discards
    )
}

get_tests <- function() {
  getOption("quickcheck.tests", 100L)
}

get_size <- function() {
  getOption("quickcheck.size", 50L)
}

get_shrinks <- function() {
  getOption("quickcheck.shrinks", 100L)
}

get_discards <- function() {
  getOption("quickcheck.discards", 100L)
}

assert_generators_named <- function(a) {
  list_names <-
    names(a)

  if (is.null(list_names) || any(list_names == ""))
    fail("All generators must be named")

  else
    a
}
