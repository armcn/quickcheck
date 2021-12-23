test_that("fails with no generators provided", {
  expect_error(
    one_of(),
    regexp = "Argument can't be empty."
  )
})


test_that("fails with hedgehog generator", {
  expect_error(
    one_of(hedgehog::gen.element(1L)),
    regexp = "Argument must be a quickcheck generator."
  )
})


test_that("ignores first generator when prob = 0", {
  for_all(
    a = one_of(
      integer_positive(),
      integer_negative(),
      prob = c(0, 1)
    ),
    property = \(a) expect_true(a < 0L)
  )
})


test_that("ignores second generator when prob = 0", {
  for_all(
    a = one_of(
      integer_positive(),
      integer_negative(),
      prob = c(1, 0)
    ),
    property = \(a) expect_true(a > 0L)
  )
})
