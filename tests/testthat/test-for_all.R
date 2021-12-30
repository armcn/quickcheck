test_that("passes with a single generator", {
  expect_silent(
    for_all(
      a = \() hedgehog::gen.choice(0),
      property = \(a) expect_equal(a, 0)
    )
  )
})


test_that("passes with multiple generators", {
  expect_silent(
    for_all(
      a = \() hedgehog::gen.choice(0),
      b = \() hedgehog::gen.choice(0),
      property = \(a, b) expect_equal(a + b, 0)
    )
  )
})


test_that("fails with no expectation", {
  expect_error(
    for_all(
      a = \() hedgehog::gen.choice(0),
      property = \(a) a == 0
    )
  )
})
