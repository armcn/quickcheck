test_that("hms_ generates hms vectors", {
  for_all(
    a = hms_(),
    property = \(a) hms::is_hms(a) |> expect_true()
  )
})

test_that("hms_ doesn't generate NAs by default", {
  for_all(
    a = hms_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("hms_ generates vectors of length 1 by default", {
  for_all(
    a = hms_(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("hms_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = hms_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("hms_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = hms_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("hms_ can generate vectors with NAs", {
  for_all(
    a = hms_(len = 10L, frac_na = 1),
    property = \(a) is_na_real(a) |> all() |> expect_true()
  )
})

test_that("hms_bounded generates bounded hms vectors", {
  left <- hms::as_hms("00:00:00")
  right <- hms::as_hms("12:00:00")

  for_all(
    a = hms_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that("hms_left_bounded generates left bounded hms vectors", {
  left <- hms::as_hms("00:00:00")

  for_all(
    a = hms_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})

test_that("hms_right_bounded generates right bounded hms vectors", {
  right <- hms::as_hms("12:00:00")

  for_all(
    a = hms_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})
