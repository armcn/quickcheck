test_suite_vector_generator(double_, is.double)

test_suite_vector_generator(double_positive, is.double)

test_suite_vector_generator(double_negative, is.double)

test_suite_vector_generator(
  purrr::partial(double_bounded, left = -10L, right = 10L),
  is.double
)

test_suite_vector_generator(
  purrr::partial(double_left_bounded, left = -10L),
  is.double
)

test_suite_vector_generator(
  purrr::partial(double_right_bounded, right = 10L),
  is.double
)

test_that("double_ can generate vectors with NaNs", {
  for_all(
    a = double_(len = 100L, any_nan = TRUE),
    property = function(a) unlist(a) %>% is.nan() %>% any() %>% expect_true()
  )
})

test_that("double_ can generate vectors with Infs", {
  for_all(
    a = double_(len = 100L, any_inf = TRUE),
    property = function(a) unlist(a) %>% is.infinite() %>% any() %>% expect_true()
  )
})

test_that("double_ generates doubles small enough to be squared", {
  for_all(
    a = double_(len = 1L),
    property = function(a) is.infinite(a * a) %>% expect_false()
  )
})

test_that("integer_bounded generates bounded doubles", {
  left <- -100L
  right <- 100L

  for_all(
    a = integer_bounded(left = left, right = right),
    property = function(a) all(a >= left & a <= right) %>% expect_true()
  )
})

test_that("double_left_bounded generates left bounded doubles", {
  left <- 100L

  for_all(
    a = double_left_bounded(left = left),
    property = function(a) all(a >= left) %>% expect_true()
  )
})

test_that("double_right_bounded generates right bounded doubles", {
  right <- 100L

  for_all(
    a = double_right_bounded(right = right),
    property = function(a) all(a <= right) %>% expect_true()
  )
})

test_that("double_positive generates positive doubles", {
  for_all(
    a = double_positive(),
    property = function(a) all(a > 0L) %>% expect_true()
  )
})

test_that("double_negative generates negative doubles", {
  for_all(
    a = double_negative(),
    property = function(a) all(a < 0L) %>% expect_true()
  )
})

test_that("double_fractional generates fractional doubles", {
  for_all(
    a = double_fractional(),
    property = function(a) all(a %% 1L != 0L) %>% expect_true()
  )
})

test_that("double_whole generates whole doubles", {
  for_all(
    a = double_whole(),
    property = function(a) all(a %% 1L == 0L) %>% expect_true()
  )
})

test_that("max_positive_double can't be squared when big_dbl = TRUE", {
  max_dbl <-
    max_positive_double(big_dbl = TRUE)

  is.infinite(max_dbl ^ 2) %>% expect_true()
})

test_that("max_positive_double can be squared when big_dbl = FALSE", {
  max_dbl <-
    max_positive_double(big_dbl = FALSE)

  is.infinite(max_dbl ^ 2) %>% expect_false()
})
