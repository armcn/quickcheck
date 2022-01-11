test_that("any_vector generates vectors", {
  for_all(
    a = any_vector(),
    property = \(a) purrr::is_vector(a) |> expect_true()
  )
})

test_that("any_vector generates vectors of length 1 by default", {
  for_all(
    a = any_vector(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("any_vector generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = any_vector(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("any_vector generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = any_vector(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("any_vector can generate vectors with NAs", {
  for_all(
    a = any_vector(len = 10L, frac_na = 1),
    property = \(a) unlist(a) |> is.na() |> all() |> expect_true(),
    tests = 5L
  )
})
