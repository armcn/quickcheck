test_that("list_of wraps a single generator in a list", {
  for_all(
    a = integer_(),
    property = \(a) {
      for_all(
        b = list_of(a),
        property = \(b) expect_equal(b, as.list(a)),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "list_of generates lists of length 1 by default", {
  for_all(
    a = list_of(any_vector()),
    property = \(a) expect_equal(length(a), 1L)
  )
})

test_that("list_of generates lists of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = list_of(any_vector(), len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "list_of generates vectors within a range of lengths", {
  for_all(
    min_len = integer_bounded(1L, 5L),
    max_len = integer_bounded(5L, 10L),
    property = \(min_len, max_len) {
      for_all(
        a = list_of(any_vector(), len = c(min_len, max_len)),
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
})

test_that(
  "list_of generates a list with repeated constants", {
  for_all(
    a = list_of(constant(TRUE), len = 3L),
    property = \(a) expect_equal(a, list(TRUE, TRUE, TRUE))
  )
})
