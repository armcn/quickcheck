test_that("data_frame_ wraps a single generator in a data.frame", {
  for_all(
    a = any_atomic(),
    property = \(a) {
      for_all(
        b = data_frame_(col_a = constant(a), rows = 1L),
        property = \(b) expect_equal(b, data.frame(col_a = a)),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("data_frame_ generates data frames with specific number of rows", {
  for_all(
    rows = integer_bounded(1L, 10L),
    property = \(rows) {
      for_all(
        a = data_frame_(col_a = any_atomic(), rows = rows),
        property = \(a) expect_equal(nrow(a), rows),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("data_frame_ generates data frames within a range of rows", {
  for_all(
    min_rows = integer_bounded(1L, 5L),
    max_rows = integer_bounded(5L, 10L),
    property = \(min_rows, max_rows) {
      for_all(
        a = data_frame_(col_a = any_atomic(), rows = c(min_rows, max_rows)),
        property = \(a) expect_true(nrow(a) >= min_rows && nrow(a) <= max_rows),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("tibble_ wraps a single generator in a tibble", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = tibble_(col_a = constant(a), rows = 1L),
        property = \(b) expect_equal(b, dplyr::tibble(col_a = a)),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("tibble_ generates tibbles with specific number of rows", {
  for_all(
    rows = integer_bounded(1L, 10L),
    property = \(rows) {
      for_all(
        a = tibble_(col_a = any_vector(), rows = rows),
        property = \(a) expect_equal(nrow(a), rows),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("tibble_ generates tibbles within a range of rows", {
  for_all(
    min_rows = integer_bounded(1L, 5L),
    max_rows = integer_bounded(5L, 10L),
    property = \(min_rows, max_rows) {
      for_all(
        a = tibble_(col_a = any_vector(), rows = c(min_rows, max_rows)),
        property = \(a) expect_true(nrow(a) >= min_rows && nrow(a) <= max_rows),
        tests = 10L
      )
    },
    tests = 10L
  )
})
