test_that("any_tibble generates tibbles", {
  for_all(
    a = any_tibble(),
    property = \(a) is_tibble(a) |> expect_true(),
    tests = 5L
  )
})

test_that("any_tibble generates tibbles with rows and columns between 1 and 10
          by default", {
  for_all(
    a = any_tibble(),
    property = \(a) {
      rows <- nrow(a)
      cols <- ncol(a)

      expect_true(rows >= 1L && rows <= 10L && cols >= 1L && cols <= 10L)
    },
    tests = 5L
  )
})

test_that("any_tibble generates tibbles with specific number of rows and
          columns", {
  for_all(
    rows = integer_bounded(1L, 5L),
    cols = integer_bounded(1L, 5L),
    property = \(rows, cols) {
      for_all(
        a = any_tibble(rows = rows, cols = cols),
        property = \(a) expect_true(nrow(a) == rows && ncol(a) == cols),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("any_tibble generates tibbles within a range of rows", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = any_tibble(rows = c(min, max)),
        property = \(a) expect_true(nrow(a) >= min && nrow(a) <= max),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("any_tibble generates tibbles within a range of cols", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = any_tibble(cols = c(min, max)),
        property = \(a) expect_true(ncol(a) >= min && ncol(a) <= max),
        tests = 5L
      )
    },
    tests = 5L
  )
})

test_that("any_tibble can generates tibbles with NAs", {
  for_all(
    a = any_tibble(rows = 10L, cols = 10L, frac_na = 1),
    property = \(a) unlist(a) |> is.na() |> all() |> expect_true(),
    tests = 5L
  )
})
