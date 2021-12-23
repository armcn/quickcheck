test_that("fails with a hedgehog generator", {
  expect_error(
    constant(hedgehog::gen.element(1L)),
    regexp = "Argument can't be a hedgehog generator."
  )
})


test_that("fails with a quickcheck generator", {
  expect_error(
    constant(integer_()),
    regexp = "Argument can't be a quickcheck generator."
  )
})


test_that("generated values all equal argument", {
  for_all(
    a = constant(1L),
    property = \(a) expect_equal(a, 1L)
  )
})
