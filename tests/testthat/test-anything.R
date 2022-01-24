test_that("anything generates tibbles, vectors, or undefined values", {
  for_all(
    a = anything(),
    property = \(a) {
      (is_tibble(a) || is_vector(a) || is_undefined(a)) |> expect_true()
    }
  )
})
