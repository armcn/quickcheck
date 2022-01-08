test_that("double_ generates doubles", {
  for_all(
    a = double_(),
    property = \(a) is.double(a) |> expect_true()
  )
})

test_that("double_ doesn't generate NAs by default", {
  for_all(
    a = double_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("double_ doesn't generate NaNs by default", {
  for_all(
    a = double_(),
    property = \(a) a |> is.nan() |> any() |> expect_false()
  )
})

test_that("double_ doesn't generate Infs by default", {
  for_all(
    a = double_(),
    property = \(a) a |> is.infinite() |> any() |> expect_false()
  )
})

test_that("double_ generates vectors of length 1 by default", {
  for_all(
    a = double_(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("double_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = double_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("double_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = double_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("double_ can generate vectors with NAs", {
  for_all(
    a = double_(len = 10L, frac_na = 1),
    property = \(a) is_na_real(a) |> all() |> expect_true()
  )
})

test_that("double_ can generate vectors with NaNs", {
  for_all(
    a = double_(len = 10L, frac_nan = 1),
    property = \(a) is.nan(a) |> all() |> expect_true()
  )
})

test_that("double_ can generate vectors with Infs", {
  for_all(
    a = double_(len = 10L, frac_inf = 1),
    property = \(a) is.infinite(a) |> all() |> expect_true()
  )
})

test_that("double_ generates doubles small enough to be squared", {
  for_all(
    a = double_(),
    property = \(a) is.infinite(a * a) |> expect_false()
  )
})

test_that("integer_bounded generates bounded doubles", {
  left <- -100L
  right <- 100L

  for_all(
    a = integer_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that("double_left_bounded generates left bounded doubles", {
  left <- 100L

  for_all(
    a = double_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that("double_right_bounded generates right bounded doubles", {
  right <- 100L

  for_all(
    a = double_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})

test_that("double_positive generates positive doubles", {
  for_all(
    a = double_positive(),
    property = \(a) expect_true(a > 0L)
  )
})

test_that("double_negative generates negative doubles", {
  for_all(
    a = double_negative(),
    property = \(a) expect_true(a < 0L)
  )
})

test_that("double_fractional generates fractional doubles", {
  for_all(
    a = double_fractional(),
    property = \(a) expect_true(a %% 1L != 0L)
  )
})

test_that("double_whole generates whole doubles", {
  for_all(
    a = double_whole(),
    property = \(a) expect_true(a %% 1L == 0L)
  )
})

test_that("max_positive_double can't be squared when big_dbl = TRUE", {
  max_dbl <-
    max_positive_double(big_dbl = TRUE)

  is.infinite(max_dbl ^ 2) |> expect_true()
})

test_that("max_positive_double can be squared when big_dbl = FALSE", {
  max_dbl <-
    max_positive_double(big_dbl = FALSE)

  is.infinite(max_dbl ^ 2) |> expect_false()
})
