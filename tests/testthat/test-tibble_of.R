test_that("tibble_of wraps a single generator in a tibble", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = tibble_of(constant(a), rows = 1L, cols = 1L),
        property = \(b) dplyr::tibble(`...1` = a) |> expect_equal(b),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("tibble_of generates tibbles with specific number of rows and cols", {
  for_all(
    rows = integer_bounded(1L, 5L),
    cols = integer_bounded(1L, 5L),
    property = \(rows, cols) {
      for_all(
        a = tibble_of(any_vector(), rows = rows, cols = cols),
        property = \(a) expect_true(nrow(a) == rows && ncol(a) == cols),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("tibble_of generates tibbles within a range of rows", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = tibble_of(any_vector(), rows = c(min, max)),
        property = \(a) expect_true(nrow(a) >= min && nrow(a) <= max),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("tibble_of generates tibbles within a range of cols", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = tibble_of(any_vector(), cols = c(min, max)),
        property = \(a) expect_true(ncol(a) >= min && ncol(a) <= max),
        tests = 5L
      )
    },
    tests = 5L
  )
})
