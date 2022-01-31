test_that("passes with a true expectation", {
  expect_silent(
    repeat_test(property = \() expect_true(TRUE))
  )
})

test_that("fails with a false expectation", {
  expect_error(
    repeat_test(property = \() expect_true(FALSE))
  )
})

test_that("fails with no expectation", {
  expect_error(
    repeat_test(property = \() a == 0)
  )
})
