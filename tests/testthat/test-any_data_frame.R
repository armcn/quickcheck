test_that("any_data_frame generates data frames", {
  for_all(
    a = any_data_frame(),
    property = \(a) expect_true(is.data.frame(a))
  )
})

test_that("any_data_frame generates data frames with rows and columns between
          1 and 10 by default", {
  for_all(
    a = any_data_frame(),
    property = \(a) {
      rows <- nrow(a)
      cols <- ncol(a)

      expect_true(rows >= 1L && rows <= 10L && cols >= 1L && cols <= 10L)
    }
  )
})

test_that("any_data_frame generates data frames with specific number of rows
          and columns", {
  for_all(
    rows = integer_bounded(1L, 10L),
    cols = integer_bounded(1L, 10L),
    property = \(rows, cols) {
      for_all(
        a = any_data_frame(rows = rows, cols = cols),
        property = \(a) expect_true(nrow(a) == rows && ncol(a) == cols),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("any_data_frame generates data frames within a range of rows", {
  for_all(
    min = integer_bounded(1L, 5L),
    max = integer_bounded(5L, 10L),
    property = \(min, max) {
      for_all(
        a = any_data_frame(rows = c(min, max)),
        property = \(a) expect_true(nrow(a) >= min && nrow(a) <= max),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("any_data_frame generates data_frames with NAs", {
  for_all(
    a = any_data_frame(rows = 10L, cols = 10L, frac_na = 1),
    property = \(a) {
      unlist(a) |>
        is.na() |>
        all() |>
        expect_true()
    }
  )
})
