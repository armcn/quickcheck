test_that("numeric_ generates numerics", {
  for_all(
    a = numeric_(),
    property = \(a) is.numeric(a) |> expect_true()
  )
})

test_that("numeric_ doesn't generate NAs by default", {
  for_all(
    a = numeric_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("numeric_ doesn't generate NaNs", {
  for_all(
    a = numeric_(),
    property = \(a) a |> is.nan() |> any() |> expect_false()
  )
})

test_that("numeric_ doesn't generate Infs", {
  for_all(
    a = numeric_(),
    property = \(a) a |> is.infinite() |> any() |> expect_false()
  )
})

test_that("numeric_ generates vectors of length 1 by default", {
  for_all(
    a = numeric_(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("numeric_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = numeric_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("numeric_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = numeric_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("numeric_ can generate vectors with NAs", {
  for_all(
    a = numeric_(len = 10L, frac_na = 1),
    property = \(a) is_na_numeric(a) |> all() |> expect_true()
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
