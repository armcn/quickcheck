test_that("posixct_ generates POSIXct vectors", {
  for_all(
    a = posixct_(),
    property = \(a) is_posixct(a) |> expect_true()
  )
})

test_that("posixct_ doesn't generate NAs by default", {
  for_all(
    a = posixct_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("posixct_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L, len = 1L),
    property = \(len) {
      for_all(
        a = posixct_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("posixct_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L, len = 1L),
    max = integer_bounded(5L, 10L, len = 1L),
    property = \(min, max) {
      for_all(
        a = posixct_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("posixct_ can generate vectors with NAs", {
  for_all(
    a = posixct_(len = 10L, frac_na = 1),
    property = \(a) is_na_real(a) |> all() |> expect_true()
  )
})

test_that("posixct_bounded generates bounded POSIXct vectors", {
  left <- as.POSIXct("2000-01-01 00:00:00")
  right <- as.POSIXct("2010-01-01 00:00:00")

  for_all(
    a = posixct_bounded(left = left, right = right),
    property = \(a) all(a >= left & a <= right) |> expect_true()
  )
})

test_that("posixct_left_bounded generates left bounded POSIXct vectors", {
  left <- as.POSIXct("2000-01-01 00:00:00")

  for_all(
    a = posixct_left_bounded(left = left),
    property = \(a) all(a >= left) |> expect_true()
  )
})

test_that("posixct_right_bounded generates right bounded POSIXct vectors", {
  right <- as.POSIXct("2010-01-01 00:00:00")

  for_all(
    a = posixct_right_bounded(right = right),
    property = \(a) all(a <= right) |> expect_true()
  )
})
