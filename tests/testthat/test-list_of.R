test_that("list_of wraps a single generator in a list", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = list_of(constant(a)),
        property = \(b) list(a) |> expect_equal(b),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("list_of generates lists of length 1 by default", {
  for_all(
    a = list_of(any_vector()),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("list_of generates lists of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = list_of(any_vector(), len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("list_of generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = list_of(any_vector(), len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})
