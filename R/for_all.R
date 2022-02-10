#' Test properties of a function
#'
#' @param ... Named generators
#' @param property A function which takes values from from
#'   the generator and calls an expectation on it. This function must have
#'   parameters matching the generator names.
#' @param tests The number of tests to run.
#' @param shrinks The maximum number of shrinks to run when
#'   shrinking a value to find the smallest counterexample.
#' @param discards The maximum number of discards to permit
#'   when running the property.
#'
#' @examples
#' for_all(
#'   a = numeric_(len = 1L),
#'   b = numeric_(len = 1L),
#'   property = \(a, b) testthat::expect_equal(a + b, b + a)
#' )
#' @return A `testthat` expectation object.
#' @export
for_all <- function(...,
                    property,
                    tests = getOption("quickcheck.tests", 100L),
                    shrinks = getOption("quickcheck.shrinks", 100L),
                    discards = getOption("quickcheck.discards", 100L)) {
    hedgehog::forall(
      generator = eval_functions(...),
      property = property,
      tests = tests,
      shrink.limit = shrinks,
      discard.limit = discards
    )
}
