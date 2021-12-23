test_that("integer_ generates pure integers", {
  for_all(
    a = integer_(),
    property = \(a) expect_true(pure::is_pure_integer(a))
  )
})


test_that("integer_bounded generates pure integers", {
  for_all(
    a = integer_bounded(
      left = max_negative_integer(),
      right = max_positive_integer()
    ),
    property = \(a) expect_true(pure::is_pure_integer(a))
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


test_that("integer_left_bounded generates pure integers", {
  for_all(
    a = integer_left_bounded(left = max_negative_integer()),
    property = \(a) expect_true(pure::is_pure_integer(a))
  )
})


test_that(
  "integer_left_bounded generates left bounded integers", {
  left <- 100L

  for_all(
    a = integer_left_bounded(left = left),
    property = \(a) expect_true(a >= left)
  )
})


test_that("integer_right_bounded generates pure integers", {
  for_all(
    a = integer_right_bounded(
      right = max_positive_integer()
    ),
    property = \(a) expect_true(pure::is_pure_integer(a))
  )
})


test_that(
  "integer_right_bounded generates right bounded integers", {
  right <- 100L

  for_all(
    a = integer_right_bounded(right = right),
    property = \(a) expect_true(a <= right)
  )
})


test_that("integer_positive generates pure integers", {
  for_all(
    a = integer_positive(),
    property = \(a) expect_true(pure::is_pure_integer(a))
  )
})


test_that("integer_positive generates positive integers", {
  for_all(
    a = integer_positive(),
    property = \(a) expect_true(a > 0L)
  )
})


test_that("integer_negative generates pure integers", {
  for_all(
    a = integer_negative(),
    property = \(a) expect_true(pure::is_pure_integer(a))
  )
})


test_that("integer_negative generates negative integers", {
  for_all(
    a = integer_negative(),
    property = \(a) expect_true(a < 0L)
  )
})
