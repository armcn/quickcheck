test_that("anything generates tibbles, vectors, or undefined values", {
  for_all(
    a = anything(),
    property = \(a) or(is_tibble, is_vector, is_undefined)(a) |> expect_true()
  )
})
