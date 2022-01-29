test_that("tibble_ wraps a single generator in a tibble", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = tibble_(col_a = list_of(constant(a), len = 1L), rows = 1L),
        property = \(b) dplyr::tibble(col_a = list(a)) |> expect_equal(b),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("tibble_ can generate tibbles with 0 rows", {
  for_all(
    a = tibble_(a = any_vector(), rows = 0L),
    property = \(a) is_tibble(a) |> expect_true()
  )

  for_all(
    a = tibble_(a = any_vector(), rows = 0L),
    property = \(a) nrow(a) |> expect_equal(0L)
  )
})

test_that("tibble_ can generate tibbles with 0 rows and 0 columns", {
  for_all(
    a = tibble_(rows = 0L),
    property = \(a) is_tibble(a) |> expect_true()
  )

  for_all(
    a = tibble_(rows = 0L),
    property = \(a) expect_true(nrow(a) == 0L && ncol(a) == 0L)
  )
})

test_that("tibble_ generates tibbles with rows from 1 and 10 by default", {
  for_all(
    a = tibble_(a = any_vector()),
    property = \(a) expect_true(nrow(a) >= 1L && nrow(a) <= 10L)
  )
})

test_that("tibble_ generates tibbles with specific number of rows", {
  for_all(
    rows = integer_bounded(1L, 5L, len = 1L),
    property = \(rows) {
      for_all(
        a = tibble_(col_a = any_vector(), rows = rows),
        property = \(a) nrow(a) |> expect_equal(rows),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("tibble_ generates tibbles within a range of rows", {
  for_all(
    min = integer_bounded(0L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = tibble_(
          col_a = any_vector(),
          col_b = any_vector(),
          rows = c(min, max)
        ),
        property = \(a) expect_true(nrow(a) >= min && nrow(a) <= max),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})
