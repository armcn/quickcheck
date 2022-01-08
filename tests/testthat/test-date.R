test_that("date_ generates dates", {
  for_all(
    a = date_(),
    property = \(a) is_date(a) |> expect_true()
  )
})

test_that("date_ doesn't generate NAs by default", {
  for_all(
    a = date_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("date_ generates vectors of length 1 by default", {
  for_all(
    a = date_(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("date_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = date_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("date_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = date_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("date_ can generate vectors with NAs", {
  for_all(
    a = date_(len = 10L, frac_na = 1),
    property = \(a) is_na_real(a) |> all() |> expect_true()
  )
})

test_that("date_bounded generates bounded dates", {
  left <- as.Date("2000-01-01")
  right <- as.Date("2010-01-01")

  for_all(
    a = date_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that("date_left_bounded generates left bounded dates", {
  left <- as.Date("2000-01-01")

  for_all(
    a = date_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that("date_right_bounded generates right bounded dates", {
  right <- as.Date("2010-01-01")

  for_all(
    a = date_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})
