test_that("posixct_ generates pure POSIXct", {
  for_all(
    a = posixct_(),
    property = \(a) expect_true(pure::is_pure_posixct(a))
  )
})

test_that(
  "posixct_ generates vectors of length 1 by default", {
  for_all(
    a = posixct_(),
    property = \(a) expect_equal(length(a), 1L)
  )
})

test_that(
  "posixct_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = posixct_(len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "posixct_ generates vectors within a range of lengths", {
  for_all(
    min_len = integer_bounded(1L, 5L),
    max_len = integer_bounded(5L, 10L),
    property = \(min_len, max_len) {
      for_all(
        a = posixct_(len = c(min_len, max_len)),
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

test_that("posixct_ generates vectors with NAs", {
  for_all(
    a = posixct_(len = 10L, frac_na = 1),
    property = \(a) expect_true(all(is.na(a)))
  )
})

test_that("posixct_bounded generates bounded POSIXct", {
  left <- as.POSIXct("2000-01-01 00:00:00")
  right <- as.POSIXct("2010-01-01 00:00:00")

  for_all(
    a = posixct_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that(
  "posixct_left_bounded generates left bounded POSIXct", {
  left <- as.POSIXct("2000-01-01 00:00:00")

  for_all(
    a = posixct_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that(
  "posixct_right_bounded generates right bounded POSIXct", {
  right <- as.POSIXct("2010-01-01 00:00:00")

  for_all(
    a = posixct_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})
