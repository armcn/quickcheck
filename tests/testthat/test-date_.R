test_that("date_ generates pure dates", {
  for_all(
    a = date_(),
    property = \(a) expect_true(pure::is_pure_date(a))
  )
})

test_that(
  "date_ generates vectors of length 1 by default", {
  for_all(
    a = date_(),
    property = \(a) expect_equal(length(a), 1L)
  )
})

test_that(
  "date_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = date_(len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "date_ generates vectors within a range of lengths", {
  for_all(
    min_len = integer_bounded(1L, 5L),
    max_len = integer_bounded(5L, 10L),
    property = \(min_len, max_len) {
      for_all(
        a = date_(len = c(min_len, max_len)),
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

test_that("date_ generates vectors with NAs", {
  for_all(
    a = date_(len = 10L, frac_na = 1),
    property = \(a) expect_true(all(is.na(a)))
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

test_that(
  "date_left_bounded generates left bounded dates", {
  left <- as.Date("2000-01-01")

  for_all(
    a = date_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that(
  "date_right_bounded generates right bounded dates", {
  right <- as.Date("2010-01-01")

  for_all(
    a = date_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})
