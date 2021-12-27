test_that("generated values all equal argument", {
  for_all(
    a = constant(1L),
    property = \(a) expect_equal(a, 1L)
  )
})
