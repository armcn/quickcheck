test_that("fails for length of 0", {
  expect_error(
    for_all(
      a = integer_() |> with_length(of = 0),
      property = \(a) expect_true(TRUE)
    ),
    regexp = "`of` must be a positive number"
  )

  expect_error(
    for_all(
      a = integer_() |> with_length(from = 0, to = 1),
      property = \(a) expect_true(TRUE)
    ),
    regexp = "`from` must be a positive number"
  )
})


test_that("fails for negative lengths", {
  expect_error(
    for_all(
      a = integer_() |> with_length(of = -1),
      property = \(a) expect_true(TRUE)
    ),
    regexp = "`of` must be a positive number"
  )
})


test_that("fails for invalid bounds", {
  expect_error(
    for_all(
      a = integer_() |> with_length(from = -1, to = 1),
      property = \(a) expect_true(TRUE)
    ),
    regexp = "`from` must be a positive number"
  )

  expect_error(
    for_all(
      a = integer_() |> with_length(from = 1, to = -1),
      property = \(a) expect_true(TRUE)
    ),
    regexp = "`to` must be a positive number"
  )

  expect_error(
    for_all(
      a = integer_() |> with_length(from = 2, to = 1),
      property = \(a) expect_true(TRUE)
    ),
    regexp = "`from` must be less than `to`"
  )
})


test_that("generates scalars if no arguments", {
  for_all(
    a = integer_() |> with_length(),
    property = \(a) expect_true(length(a) == 1)
  )
})


test_that("generates vectors with specific length", {
  for_all(
    a = integer_() |> with_length(of = 3),
    property = \(a) expect_true(length(a) == 3)
  )
})


test_that("generates vectors within a length range", {
  for_all(
    a = integer_() |> with_length(from = 5, to = 10),
    property = \(a) {
      expect_true(length(a) >= 5 && length(a) <= 10)
    }
  )
})

