test_suite_vector_generator(date_, is_date)

test_suite_vector_generator(
  purrr::partial(
    date_bounded,
    left = as.Date("2000-01-01"),
    right = as.Date("2020-01-01")
  ),
  is_date
)

test_suite_vector_generator(
  purrr::partial(
    date_left_bounded,
    left = as.Date("2000-01-01")
  ),
  is_date
)

test_suite_vector_generator(
  purrr::partial(
    date_right_bounded,
    right = as.Date("2020-01-01")
  ),
  is_date
)

test_that("date_bounded generates bounded dates", {
  left <- as.Date("2000-01-01")
  right <- as.Date("2010-01-01")

  for_all(
    a = date_bounded(left = left, right = right),
    property = function(a) all(a >= left & a <= right) %>% expect_true()
  )
})

test_that("date_left_bounded generates left bounded dates", {
  left <- as.Date("2000-01-01")

  for_all(
    a = date_left_bounded(left = left),
    property = function(a) all(a >= left) %>% expect_true()
  )
})

test_that("date_right_bounded generates right bounded dates", {
  right <- as.Date("2010-01-01")

  for_all(
    a = date_right_bounded(right = right),
    property = function(a) all(a <= right) %>% expect_true()
  )
})
