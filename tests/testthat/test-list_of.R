test_that("list_of wraps a single generator in a list", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = list_of(constant(a), len = 1L),
        property = \(b) list(a) |> expect_equal(b),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("list_of can generate empty lists", {
  for_all(
    a = list_of(any_vector(), len = 0L),
    property = \(a) is.list(a) |> expect_true()
  )

  for_all(
    a = list_of(any_vector(), len = 0L),
    property = \(a) length(a) |> expect_equal(0L)
  )
})

test_that("list_of generates lists with lengths from 1 and 10 by default", {
  for_all(
    a = list_of(any_vector()),
    property = \(a) expect_true(length(a) >= 1L && length(a) <= 10L)
  )
})

test_that("list_of generates lists of specific length", {
  for_all(
    len = integer_bounded(1L, 10L, len = 1L),
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
    min = integer_bounded(0L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
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
