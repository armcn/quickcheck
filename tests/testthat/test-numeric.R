test_that("numeric_ generates pure numerics", {
  for_all(
    a = numeric_(),
    property = \(a) expect_true(pure::is_pure_numeric(a))
  )
})

test_that("numeric_ generates vectors of length 1 by default", {
  for_all(
    a = numeric_(),
    property = \(a) expect_equal(length(a), 1L)
  )
})

test_that("numeric_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = numeric_(len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("numeric_ generates vectors within a range of lengths", {
  for_all(
    min_len = integer_bounded(1L, 5L),
    max_len = integer_bounded(5L, 10L),
    property = \(min_len, max_len) {
      for_all(
        a = numeric_(len = c(min_len, max_len)),
        property = \(a) {
          expect_true(
            length(a) >= min_len && length(a) <= max_len
          )
        },
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("numeric_ generates vectors with NAs", {
  is_na_numeric <- \(a) is.na(a) & (is.integer(a) | is.double(a))

  for_all(
    a = numeric_(len = 10L, frac_na = 1),
    property = \(a) expect_true(all(is_na_numeric(a)))
  )
})

test_that("numeric_bounded generates bounded numerics", {
  left <- -100L
  right <- 100L

  for_all(
    a = numeric_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that("numeric_left_bounded generates left bounded numerics", {
  left <- 100L

  for_all(
    a = numeric_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that("numeric_right_bounded generates right bounded numerics", {
  right <- 100L

  for_all(
    a = numeric_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})

test_that("numeric_positive generates positive numerics", {
  for_all(
    a = numeric_positive(),
    property = \(a) expect_true(a > 0L)
  )
})

test_that("numeric_negative generates negative numerics", {
  for_all(
    a = numeric_negative(),
    property = \(a) expect_true(a < 0L)
  )
})
