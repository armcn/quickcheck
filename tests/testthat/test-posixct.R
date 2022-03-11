test_suite_vector_generator(posixct_, is_posixct)

test_suite_vector_generator(
  purrr::partial(
    posixct_bounded,
    left = as.POSIXct("2000-01-01 00:00:00"),
    right = as.POSIXct("2020-01-01 00:00:00")
  ),
  is_posixct
)

test_suite_vector_generator(
  purrr::partial(
    posixct_left_bounded,
    left = as.POSIXct("2000-01-01 00:00:00")
  ),
  is_posixct
)

test_suite_vector_generator(
  purrr::partial(
    posixct_right_bounded,
    right = as.POSIXct("2020-01-01 00:00:00")
  ),
  is_posixct
)

test_that("posixct_bounded generates bounded POSIXct vectors", {
  left <- as.POSIXct("2000-01-01 00:00:00")
  right <- as.POSIXct("2010-01-01 00:00:00")

  for_all(
    a = posixct_bounded(left = left, right = right),
    property = function(a) all(a >= left & a <= right) %>% expect_true()
  )
})

test_that("posixct_left_bounded generates left bounded POSIXct vectors", {
  left <- as.POSIXct("2000-01-01 00:00:00")

  for_all(
    a = posixct_left_bounded(left = left),
    property = function(a) all(a >= left) %>% expect_true()
  )
})

test_that("posixct_right_bounded generates right bounded POSIXct vectors", {
  right <- as.POSIXct("2010-01-01 00:00:00")

  for_all(
    a = posixct_right_bounded(right = right),
    property = function(a) all(a <= right) %>% expect_true()
  )
})
