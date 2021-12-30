test_that("integer_ generates pure integers", {
  for_all(
    a = integer_(),
    property = \(a) expect_true(pure::is_pure_integer(a))
  )
})

test_that(
  "integer_ generates vectors of length 1 by default",
  {
    for_all(
      a = integer_(),
      property = \(a) expect_equal(length(a), 1L)
    )
  }
)

test_that("integer_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = integer_(len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "integer_ generates vectors within a range of lengths",
  {
    for_all(
      min_len = integer_bounded(1L, 5L),
      max_len = integer_bounded(5L, 10L),
      property = \(min_len, max_len) {
        for_all(
          a = integer_(len = c(min_len, max_len)),
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

test_that("integer_ generates vectors with NAs", {
  for_all(
    a = integer_(len = 10L, frac_na = 1),
    property = \(a) expect_true(all(is.na(a)))
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

test_that(
  "integer_left_bounded generates left bounded integers",
  {
    left <- 100L

    for_all(
      a = integer_left_bounded(left = left),
      property = \(a) expect_true(a >= left)
    )
  }
)

test_that(
  "integer_right_bounded generates right bounded integers",
  {
    right <- 100L

    for_all(
      a = integer_right_bounded(right = right),
      property = \(a) expect_true(a <= right)
    )
  }
)

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
