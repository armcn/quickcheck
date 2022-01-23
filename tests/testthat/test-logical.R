test_that("logical_ generates logicals", {
  for_all(
    a = logical_(),
    property = \(a) is.logical(a) |> expect_true()
  )
})

test_that("logical_ doesn't generate NAs by default", {
  for_all(
    a = logical_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("logical_ can generate empty vectors", {
  for_all(
    a = logical_(len = 0L),
    property = \(a) is.logical(a) |> expect_true()
  )

  for_all(
    a = logical_(len = 0L),
    property = \(a) length(a) |> expect_equal(0L)
  )
})

test_that("logical_ generates vectors with lengths from 1 and 10 by default", {
  for_all(
    a = logical_(),
    property = \(a) expect_true(length(a) >= 1L && length(a) <= 10L)
  )
})

test_that("logical_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L, len = 1L),
    property = \(len) {
      for_all(
        a = logical_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("logical_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = logical_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("logical_ can generate vectors with NAs", {
  for_all(
    a = logical_(len = 10L, frac_na = 1),
    property = \(a) is_na_logical(a) |> all() |> expect_true()
  )
})
