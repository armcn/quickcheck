test_that("tibble_ wraps a single generator in a tibble", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = tibble_(col_a = constant(a), rows = 1L),
        property = \(b) dplyr::tibble(col_a = a) |> expect_equal(b),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("tibble_ generates tibbles with specific number of rows", {
  for_all(
    rows = integer_bounded(1L, 5L),
    property = \(rows) {
      for_all(
        a = tibble_(col_a = any_vector(), rows = rows),
        property = \(a) nrow(a) |> expect_equal(rows),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("tibble_ generates tibbles within a range of rows", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = tibble_(col_a = any_vector(), rows = c(min, max)),
        property = \(a) expect_true(nrow(a) >= min && nrow(a) <= max),
        tests = 5L
      )
    },
    tests = 5L
  )
})
