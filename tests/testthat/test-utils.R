test_that("sample_vec takes a single sample by default", {
  expect_equal(sample_vec(1L), 1L)
  expect_equal(sample_vec(c(5L, 5L)), 5L)
})
