test_that("repeat_test passes with a true expectation", {
  expect_silent(
    repeat_test(property = function() expect_true(TRUE))
  )
})

test_that("repeat_test fails with a false expectation", {
  expect_error(
    repeat_test(property = function() expect_true(FALSE))
  )
})

test_that("repeat_test fails with no expectation", {
  expect_error(
    repeat_test(property = function() a == 0)
  )
})
