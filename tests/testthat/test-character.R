test_that("character_ generates characters", {
  for_all(
    a = character_(),
    property = \(a) is.character(a) |> expect_true()
  )
})

test_that("character_ doesn't generate NAs by default", {
  for_all(
    a = character_(),
    property = \(a) a |> is.na() |> any() |> expect_false()
  )
})

test_that("character_ doesn't generate empty characters by default", {
  for_all(
    a = character_(),
    property = \(a) a |> is_empty_character() |> any() |> expect_false()
  )
})

test_that("character_ generates vectors of length 1 by default", {
  for_all(
    a = character_(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("character_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = character_(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("character_ generates vectors within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = character_(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("character_ can generate vectors with NAs", {
  for_all(
    a = character_(len = 10L, frac_na = 1),
    property = \(a) is_na_character(a) |> all() |> expect_true()
  )
})

test_that("character_ can generate vectors with empty characters", {
  for_all(
    a = character_(len = 10L, frac_empty = 1),
    property = \(a) is_empty_character(a) |> all() |> expect_true()
  )
})
