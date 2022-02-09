test_suite_data_frame_of_generator(tibble_of, is_tibble)

test_that("tibble_of wraps a single generator in a tibble", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = tibble_of(list_of(constant(a), len = 1L), rows = 1L, cols = 1L),
        property = \(b) dplyr::tibble(`...1` = list(a)) |> expect_equal(b),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("tibble_of can generate tibbles with 0 rows", {
  for_all(
    a = tibble_of(any_vector(), rows = 0L),
    property = \(a) is_tibble(a) |> expect_true()
  )

  for_all(
    a = tibble_of(any_vector(), rows = 0L),
    property = \(a) nrow(a) |> expect_equal(0L)
  )
})

test_that("tibble_of can generate tibbles with 0 columns", {
  for_all(
    a = tibble_of(any_vector(), cols = 0L),
    property = \(a) is_tibble(a) |> expect_true()
  )

  for_all(
    a = tibble_of(any_vector(), cols = 0L),
    property = \(a) ncol(a) |> expect_equal(0L)
  )
})

test_that("tibble_of can generate tibbles with 0 rows and 0 columns", {
  for_all(
    a = tibble_of(any_vector(), rows = 0L, cols = 0L),
    property = \(a) is_tibble(a) |> expect_true()
  )

  for_all(
    a = tibble_of(any_vector(), rows = 0L, cols = 0L),
    property = \(a) expect_true(nrow(a) == 0L && ncol(a) == 0L)
  )
})

test_that("tibble_of generates tibbles with dimensions from 1 and 10 by default", {
  for_all(
    a = tibble_of(any_vector()),
    property = \(a) {
      expect_true(
        nrow(a) >= 1L && nrow(a) <= 10L &&
        ncol(a) >= 1L && ncol(a) <= 10L
      )
    }
  )
})

test_that("tibble_of generates tibbles with specific number of rows and cols", {
  for_all(
    rows = integer_bounded(1L, 5L, len = 1L),
    cols = integer_bounded(1L, 5L, len = 1L),
    property = \(rows, cols) {
      for_all(
        a = tibble_of(any_vector(), rows = rows, cols = cols),
        property = \(a) expect_true(nrow(a) == rows && ncol(a) == cols),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("tibble_of generates tibbles within a range of rows", {
  for_all(
    min = integer_bounded(0L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = tibble_of(any_vector(), rows = c(min, max)),
        property = \(a) expect_true(nrow(a) >= min && nrow(a) <= max),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("tibble_of generates tibbles within a range of cols", {
  for_all(
    min = integer_bounded(0L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = tibble_of(any_vector(), cols = c(min, max)),
        property = \(a) expect_true(ncol(a) >= min && ncol(a) <= max),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})
