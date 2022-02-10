test_that("one_of doesn't modify a single generator", {
  for_all(
    a = anything(),
    property = \(a) {
      for_all(
        b = one_of(constant(a)),
        property = \(b) expect_equal(a, b),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("one_of can ignore the first generator", {
  for_all(
    a = one_of(
      integer_positive(),
      integer_negative(),
      prob = c(0, 1)
    ),
    property = \(a) all(a < 0L) |> expect_true()
  )
})

test_that("one_of can ignore the second generator", {
  for_all(
    a = one_of(
      integer_positive(),
      integer_negative(),
      prob = c(1, 0)
    ),
    property = \(a) all(a > 0L) |> expect_true()
  )
})
