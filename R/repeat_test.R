#' Repeatedly test properties of a function
#'
#' @param property A function with no parameters which includes an expectation.
#' @param tests The number of tests to run.
#'
#' @examples
#' repeat_test(
#'   property = \() {
#'     num <- stats::runif(1, min = 0, max = 10)
#'     testthat::expect_true(num >= 0 && num <= 10)
#'   }
#' )
#' @return A `testthat` expectation object.
#' @export
repeat_test <- function(property,
                        tests = getOption("quickcheck.tests", 100L)) {
  for_all(
    a = constant(NULL),
    property = \(a) property(),
    tests = tests
  )
}
