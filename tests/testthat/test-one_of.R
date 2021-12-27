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
