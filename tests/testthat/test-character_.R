test_that("character_ generates pure characters", {
  for_all(
    a = character_(),
    property = \(a) expect_true(pure::is_pure_character(a))
  )
})

test_that(
  "character_ generates vectors of length 1 by default", {
  for_all(
    a = character_(),
    property = \(a) expect_equal(length(a), 1L)
  )
})

test_that(
  "character_ generates vectors of specific length", {
  for_all(
    len = integer_bounded(1L, 10L),
    property = \(len) {
      for_all(
        a = character_(len = len),
        property = \(a) expect_equal(length(a), len),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that(
  "character_ generates vectors within a range of lengths", {
  for_all(
    min_len = integer_bounded(1L, 5L),
    max_len = integer_bounded(5L, 10L),
    property = \(min_len, max_len) {
      for_all(
        a = character_(len = c(min_len, max_len)),
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
