test_that("one_of with single generator doesn't change generator", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = one_of(constant(a)),
        property = \(b) expect_equal(a, b),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("one_of can ignore the first generator", {
  for_all(
    a = one_of(
      integer_positive(),
      integer_negative(),
      prob = c(0, 1)
    ),
    property = \(a) expect_true(a < 0L)
  )
})

test_that("one_of can ignore the second generator", {
  for_all(
    a = one_of(
      integer_positive(),
      integer_negative(),
      prob = c(1, 0)
    ),
    property = \(a) expect_true(a > 0L)
  )
})
