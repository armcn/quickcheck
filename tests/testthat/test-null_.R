test_that("null_ generates NULLs", {
  for_all(
    a = null_(),
    property = \(a) expect_equal(a, NULL)
  )
})
