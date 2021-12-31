test_that("overlaps_zero checks if a range overlaps zero", {
  expect_true(overlaps_zero(-1, 1))
  expect_true(overlaps_zero(0, 1))
  expect_false(overlaps_zero(1, 2))
  expect_false(overlaps_zero(-1, -2))
})

test_that("fail creates an error", {
  expect_error(fail())
})

test_that("qc_gen adds the quickcheck_generator class to a function", {
  f <- qc_gen(\(a) a)
  expect_true(is.function(f) && inherits(f, "quickcheck_generator"))
})

test_that("sample_vec takes a single sample by default", {
  expect_equal(sample_vec(1L), 1L)
  expect_equal(sample_vec(c(5L, 5L)), 5L)
})
