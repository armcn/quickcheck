test_suite_vector_generator(integer_, is.integer)

test_suite_vector_generator(integer_positive, is.integer)

test_suite_vector_generator(integer_negative, is.integer)

test_suite_vector_generator(
  purrr::partial(integer_bounded, left = -10L, right = 10L),
  is.integer
)

test_suite_vector_generator(
  purrr::partial(integer_left_bounded, left = -10L),
  is.integer
)

test_suite_vector_generator(
  purrr::partial(integer_right_bounded, right = 10L),
  is.integer
)

test_that("integer_ generates integers small enough to be squared", {
  for_all(
    a = integer_(),
    property = \(a) is.integer(a * a) |> expect_true()
  )
})

test_that("integer_bounded generates bounded integers", {
  left <- -100L
  right <- 100L

  for_all(
    a = integer_bounded(left = left, right = right),
    property = \(a) all(a >= left & a <= right) |> expect_true()
  )
})

test_that("integer_left_bounded generates left bounded integers", {
  left <- 100L

  for_all(
    a = integer_left_bounded(left = left),
    property = \(a) all(a >= left) |> expect_true()
  )
})

test_that("integer_right_bounded generates right bounded integers", {
  right <- 100L

  for_all(
    a = integer_right_bounded(right = right),
    property = \(a) all(a <= right) |> expect_true()
  )
})

test_that("integer_positive generates positive integers", {
  for_all(
    a = integer_positive(),
    property = \(a) all(a > 0L) |> expect_true()
  )
})

test_that("integer_negative generates negative integers", {
  for_all(
    a = integer_negative(),
    property = \(a) all(a < 0L) |> expect_true()
  )
})

test_that("max_positive_integer can't be squared when big_int = TRUE", {
  max_int <-
    max_positive_integer(big_int = TRUE)

  expect_warning(
    max_int * max_int,
    regexp = "NAs produced by integer overflow"
  )
})

test_that("max_positive_integer can be squared when big_int = FALSE", {
  max_int <-
    max_positive_integer(big_int = FALSE)

  is.integer(max_int * max_int) |> expect_true()
})
