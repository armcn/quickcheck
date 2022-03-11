test_suite_vector_generator(numeric_, is.numeric)

test_suite_vector_generator(numeric_positive, is.numeric)

test_suite_vector_generator(numeric_negative, is.numeric)

test_suite_vector_generator(
  purrr::partial(numeric_bounded, left = -10L, right = 10L),
  is.numeric
)

test_suite_vector_generator(
  purrr::partial(numeric_left_bounded, left = -10L),
  is.numeric
)

test_suite_vector_generator(
  purrr::partial(numeric_right_bounded, right = 10L),
  is.numeric
)

test_that("numeric_ doesn't generate NaNs", {
  for_all(
    a = numeric_(),
    property = function(a) a %>% is.nan() %>% any() %>% expect_false()
  )
})

test_that("numeric_ doesn't generate Infs", {
  for_all(
    a = numeric_(),
    property = function(a) a %>% is.infinite() %>% any() %>% expect_false()
  )
})

test_that("numeric_bounded generates bounded numerics", {
  left <- -100L
  right <- 100L

  for_all(
    a = numeric_bounded(left = left, right = right),
    property = function(a) all(a >= left & a <= right) %>% expect_true()
  )
})

test_that("numeric_left_bounded generates left bounded numerics", {
  left <- 100L

  for_all(
    a = numeric_left_bounded(left = left),
    property = function(a) all(a >= left) %>% expect_true()
  )
})

test_that("numeric_right_bounded generates right bounded numerics", {
  right <- 100L

  for_all(
    a = numeric_right_bounded(right = right),
    property = function(a) all(a <= right) %>% expect_true()
  )
})

test_that("numeric_positive generates positive numerics", {
  for_all(
    a = numeric_positive(),
    property = function(a) all(a > 0L) %>% expect_true()
  )
})

test_that("numeric_negative generates negative numerics", {
  for_all(
    a = numeric_negative(),
    property = function(a) all(a < 0L) %>% expect_true()
  )
})
