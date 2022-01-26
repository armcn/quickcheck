test_that("passes with a true expectation", {
  expect_silent(
    repeat_check(property = \(a) expect_true(TRUE))
  )
})

test_that("fails with a false expectation", {
  expect_error(
    repeat_check(property = \(a, b) expect_true(FALSE))
  )
})

test_that("fails with no expectation", {
  expect_error(
    repeat_check(property = \(a) a == 0)
  )
})
