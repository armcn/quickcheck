test_that("equal_length wraps a single generator in a list", {
  vector_generator <-
    any_vector(len = c(0L, 10L), any_na = TRUE)

  for_all(
    a = equal_length(vector_generator),
    property = \(a) is.list(a) |> expect_true()
  )
})

test_that("equal_length can generate empty vectors", {
  for_all(
    a = equal_length(any_vector(), any_vector(), len = 0L),
    property = \(a)
      purrr::map(a, length) |> equals(0) |> all() |> expect_true()
  )
})

test_that("equal_length generates vectors with length from 1 and 10 by default", {
  for_all(
    a = equal_length(any_vector()),
    property = \(a)
      (length(a) >= 1L && length(a) <= 10L) |> expect_true()
  )
})

test_that("equal_length generates lists of vectors with a specific length", {
  for_all(
    len = integer_bounded(1L, 10L, len = 1L),
    property = \(len) {
      for_all(
        a = equal_length(any_vector(), any_vector(), len = len),
        property = \(a)
          purrr::map(a, length) |> equals(len) |> all() |> expect_true(),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("equal_length generates lists of vectors within a range of lengths", {
  for_all(
    min = integer_bounded(0L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = equal_length(any_vector(), any_vector(), len = c(min, max)),
        property = \(a)
          purrr::map(a, length) |>
            {\(a) all(a >= min & a <= max)}() |>
            expect_true(),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("equal_length fails if generators don't have modifiable lengths", {
  non_modifiable_length <-
    any_vector() |> as_hedgehog() |> from_hedgehog()

  repeat_test(
    property = \() equal_length(non_modifiable_length) |> expect_error()
  )
})
