test_that("double_ generates pure doubles", {
  for_all(
    a = double_(),
    property = \(a) expect_true(pure::is_pure_double(a))
  )
})

test_that(
  "double_ generates vectors of length 1 by default",
  {
    for_all(
      a = double_(),
      property = \(a) expect_equal(length(a), 1L)
    )
  }
)

test_that("double_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = double_(len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "double_ generates vectors within a range of lengths",
  {
    for_all(
      min_len = integer_bounded(1L, 5L),
      max_len = integer_bounded(5L, 10L),
      property = \(min_len, max_len) {
        for_all(
          a = double_(len = c(min_len, max_len)),
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

test_that("double_ generates vectors with NAs", {
  for_all(
    a = double_(len = 10L, frac_na = 1),
    property = \(a) expect_true(all(is.na(a)))
  )
})

test_that("double_ generates vectors with NaNs", {
  for_all(
    a = double_(len = 10L, frac_nan = 1),
    property = \(a) expect_true(all(is.nan(a)))
  )
})

test_that("double_ generates vectors with Infs", {
  for_all(
    a = double_(len = 10L, frac_inf = 1),
    property = \(a) expect_true(all(is.infinite(a)))
  )
})

test_that("double_bounded generates bounded doubles", {
  left <- -100L
  right <- 100L

  for_all(
    a = double_bounded(left = left, right = right),
    property = \(a) expect_true(a >= left && a <= right)
  )
})

test_that(
  "double_left_bounded generates left bounded doubles",
  {
    left <- 100L

    for_all(
      a = double_left_bounded(left = left),
      property = \(a) expect_true(a >= left)
    )
  }
)

test_that(
  "double_right_bounded generates right bounded doubles",
  {
    right <- 100L

    for_all(
      a = double_right_bounded(right = right),
      property = \(a) expect_true(a <= right)
    )
  }
)

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

test_that(
  "double_fractional generates fractional doubles",
  {
    for_all(
      a = double_fractional(),
      property = \(a) expect_true(a %% 1L != 0L)
    )
  }
)

test_that("double_whole generates whole doubles", {
  for_all(
    a = double_whole(),
    property = \(a) expect_true(a %% 1L == 0L)
  )
})
