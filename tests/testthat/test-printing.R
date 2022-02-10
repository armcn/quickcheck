test_that("quickcheck generators print correctly", {
  print(integer_()) |> expect_output("Quickcheck generator:")

  print(integer_()) |> expect_output("Example:")

  print(integer_()) |> expect_output("Initial shrinks:")

  print(constant(TRUE)) |> expect_output("TRUE")
})
