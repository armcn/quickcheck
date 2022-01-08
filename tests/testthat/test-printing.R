test_that("quickcheck generators print correctly", {
  print(integer_()) |> expect_output("Hedgehog generator:")

  print(integer_()) |> expect_output("Example:")

  print(integer_()) |> expect_output("Initial shrinks:")

  print(constant(TRUE)) |> expect_output("TRUE")
})

test_that("show_example returns an example", {
  constant("hello") |> show_example() |> expect_equal("hello")
})
