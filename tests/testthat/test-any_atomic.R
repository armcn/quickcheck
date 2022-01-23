test_that("any_atomic generates atomic vectors", {
  for_all(
    a = any_atomic(),
    property = \(a) is.atomic(a) |> expect_true()
  )
})

test_that("any_atomic generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L, len = 1L),
    property = \(len) {
      for_all(
        a = any_atomic(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("any_atomic generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = any_atomic(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})
