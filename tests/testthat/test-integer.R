test_that("integer_ generates integers", {
  for_all(
    a = integer_(),
    property = \(a) is.integer(a) |> expect_true()
  )
})

test_that("integer_ doesn't generate NAs by default", {
  for_all(
    a = integer_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("integer_ generates vectors of length 1 by default", {
  for_all(
    a = integer_(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("integer_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = integer_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("integer_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = integer_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("integer_ can generate vectors with NAs", {
  for_all(
    a = integer_(len = 10L, frac_na = 1),
    property = \(a) is_na_integer(a) |> all() |> expect_true()
  )
})

test_that("integer_ generates integers small enough to be squared", {
  for_all(
    a = integer_(),
    property = \(a) is.integer(a * a) |> expect_true()
  )
})

test_that("integer_bounded generates bounded integers", {
  left <- -100L
  right <- 100L

  for_all(
    a = integer_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that("integer_left_bounded generates left bounded integers", {
  left <- 100L

  for_all(
    a = integer_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that("integer_right_bounded generates right bounded integers", {
  right <- 100L

  for_all(
    a = integer_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})

test_that("integer_positive generates positive integers", {
  for_all(
    a = integer_positive(),
    property = \(a) expect_true(a > 0L)
  )
})

test_that("integer_negative generates negative integers", {
  for_all(
    a = integer_negative(),
    property = \(a) expect_true(a < 0L)
  )
})

test_that("max_positive_integer can't be squared when big_int = TRUE", {
  max_int <-
    max_positive_integer(big_int = TRUE)

  expect_warning(
    max_int * max_int,
    regexp = "NAs produced by integer overflow"
  )
})

test_that("max_positive_integer can be squared when big_int = FALSE", {
  max_int <-
    max_positive_integer(big_int = FALSE)

  is.integer(max_int * max_int) |> expect_true()
})
