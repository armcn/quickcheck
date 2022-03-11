test_that("for_all passes with a single generator", {
  expect_silent(
    for_all(
      a = constant(0),
      property = function(a) expect_equal(a, 0)
    )
  )
})

test_that("for_all passes with multiple generators", {
  expect_silent(
    for_all(
      a = constant(-1),
      b = constant(1),
      property = function(a, b) expect_equal(a + b, 0)
    )
  )
})

test_that("for_all fails with no expectation", {
  expect_error(
    for_all(
      a = constant(0),
      property = function(a) a == 0
    )
  )
})
