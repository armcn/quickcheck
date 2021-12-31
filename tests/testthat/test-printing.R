test_that("quickcheck generators print correctly", {
  expect_output(
    print(integer_()),
    regexp = "Hedgehog generator:"
  )

  expect_output(
    print(integer_()),
    regexp = "Example:"
  )

  expect_output(
    print(integer_()),
    regexp = "Initial shrinks:"
  )

  expect_output(
    print(constant(TRUE)),
    regexp = "TRUE"
  )
})

test_that("show_example returns an example", {
  expect_equal(
    constant("hello") |> show_example(),
    "hello"
  )
})
