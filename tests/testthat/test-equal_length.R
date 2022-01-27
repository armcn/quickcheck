test_that("equal_length wraps a single generator in a list", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = equal_length(constant(a), len = 1L),
        property = \(b) list(a) |> expect_equal(b),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("equal_length can generate empty vectors", {
  for_all(
    a = equal_length(any_vector(), any_vector(), len = 0L),
    property = \(a) {
      purrr::map(a, length) |> equals(0) |> all() |> expect_true()
    }
  )
})

test_that("equal_length generates vectors with length from 1 and 10 by default", {
  for_all(
    a = equal_length(any_vector()),
    property = \(a) expect_true(length(a) >= 1L && length(a) <= 10L)
  )
})

test_that("equal_length generates lists of vectors with a specific length", {
  for_all(
    len = integer_bounded(1L, 5L, len = 1L),
    property = \(len) {
      for_all(
        a = equal_length(any_vector(), len = len),
        property = \(a) length(a[[1]]) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("equal_length generates lists of vectors within a range of lengths", {
  for_all(
    min = integer_bounded(0L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = equal_length(any_vector(), any_vector(), len = c(min, max)),
        property = \(a) {
          purrr::map(a, length) |>
            {\(a) all(a >= min & a <= max)}() |>
            expect_true()
        },
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})
