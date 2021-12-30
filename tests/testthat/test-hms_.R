test_that("hms_ generates pure hms", {
  for_all(
    a = hms_(),
    property = \(a) expect_true(pure::is_pure_hms(a))
  )
})

test_that(
  "hms_ generates vectors of length 1 by default",
  {
    for_all(
      a = hms_(),
      property = \(a) expect_equal(length(a), 1L)
    )
  }
)

test_that(
  "hms_ generates vectors of specific length",
  {
    for_all(
      len = integer_bounded(1L, 10L),
      property = \(len) {
        for_all(
          a = hms_(len = len),
          property = \(a) expect_equal(length(a), len),
          tests = 10L
        )
      },
      tests = 10L
    )
  }
)

test_that(
  "hms_ generates vectors within a range of lengths",
  {
    for_all(
      min_len = integer_bounded(1L, 5L),
      max_len = integer_bounded(5L, 10L),
      property = \(min_len, max_len) {
        for_all(
          a = hms_(len = c(min_len, max_len)),
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
  }
)

test_that("hms_ generates vectors with NAs", {
  for_all(
    a = hms_(len = 10L, frac_na = 1),
    property = \(a) expect_true(all(is.na(a)))
  )
})

test_that("hms_bounded generates bounded hms", {
  left <- hms::as_hms("00:00:00")
  right <- hms::as_hms("12:00:00")

  for_all(
    a = hms_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that(
  "hms_left_bounded generates left bounded hms",
  {
    left <- hms::as_hms("00:00:00")

    for_all(
      a = hms_left_bounded(left = left),
      property = \(a) expect_true(a >= left)
    )
  }
)

test_that(
  "hms_right_bounded generates right bounded hms",
  {
    right <- hms::as_hms("12:00:00")

    for_all(
      a = hms_right_bounded(right = right),
      property = \(a) expect_true(a <= right)
    )
  }
)
