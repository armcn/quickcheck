test_suite_vector_generator(hms_, hms::is_hms)

test_suite_vector_generator(
  purrr::partial(
    hms_bounded,
    left = hms::as_hms("00:00:00"),
    right = hms::as_hms("12:00:00")
  ),
  hms::is_hms
)

test_suite_vector_generator(
  purrr::partial(
    hms_left_bounded,
    left = hms::as_hms("00:00:00")
  ),
  hms::is_hms
)

test_suite_vector_generator(
  purrr::partial(
    hms_right_bounded,
    right = hms::as_hms("12:00:00")
  ),
  hms::is_hms
)

test_that("hms_bounded generates bounded hms vectors", {
  left <- hms::as_hms("00:00:00")
  right <- hms::as_hms("12:00:00")

  for_all(
    a = hms_bounded(left = left, right = right),
    property = \(a) all(a >= left & a <= right) |> expect_true()
  )
})

test_that("hms_left_bounded generates left bounded hms vectors", {
  left <- hms::as_hms("00:00:00")

  for_all(
    a = hms_left_bounded(left = left),
    property = \(a) all(a >= left) |> expect_true()
  )
})

test_that("hms_right_bounded generates right bounded hms vectors", {
  right <- hms::as_hms("12:00:00")

  for_all(
    a = hms_right_bounded(right = right),
    property = \(a) all(a <= right) |> expect_true()
  )
})
