test_that("any_flat_list generates lists", {
  for_all(
    a = any_flat_list(),
    property = \(a) is.list(a) |> expect_true()
  )
})

test_that("any_flat_list generates flat lists", {
  for_all(
    a = any_flat_list(),
    property = \(a) is_flat_list(a) |> expect_true()
  )
})

test_that("any_flat_list generates lists of length 1 by default", {
  for_all(
    a = any_flat_list(),
    property = \(a) length(a) |> expect_equal(1L)
  )
})

test_that("any_flat_list generates lists of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = any_flat_list(len = len),
        property = \(a) length(a) |> expect_equal(len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("any_flat_list generates lists within a range of lengths", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = any_flat_list(len = c(min, max)),
        property = \(a) expect_true(length(a) >= min && length(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("any_flat_list can generate lists with NAs", {
  for_all(
    a = any_flat_list(len = 10L, frac_na = 1),
    property = \(a) unlist(a) |> is.na() |> all() |> expect_true()
  )
})
