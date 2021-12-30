test_that("any_vector generates pure vectors", {
  for_all(
    a = any_vector(),
    property = \(a) expect_true(pure::is_pure_vector(a))
  )
})

test_that(
  "any_vector generates lists of length 1 by default",
  {
    for_all(
      a = any_vector(),
      property = \(a) expect_equal(length(a), 1L)
    )
  }
)

test_that(
  "any_vector generates lists of specific length",
  {
    for_all(
      len = integer_bounded(1L, 10L),
      property = \(len) {
        for_all(
          a = any_vector(len = len),
          property = \(a) expect_equal(length(a), len),
          tests = 10L
        )
      },
      tests = 10L
    )
  }
)

test_that(
  "any_vector generates lists within a range of lengths",
  {
    for_all(
      min_len = integer_bounded(1L, 5L),
      max_len = integer_bounded(5L, 10L),
      property = \(min_len, max_len) {
        for_all(
          a = any_vector(len = c(min_len, max_len)),
          property = \(a) {
            expect_true(
              length(a) >= min_len && length(a) <= max_len
            )
          },
          tests = 10L
        )
      },
      tests = 10L
    )
  }
)

test_that("any_vector generates lists with NAs", {
  for_all(
    a = any_vector(len = 10L, frac_na = 1),
    property = \(a) {
      unlist(a) |>
        is.na() |>
        all() |>
        expect_true()
    }
  )
})
