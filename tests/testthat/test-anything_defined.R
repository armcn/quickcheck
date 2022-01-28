test_that("anything_defined generates tibbles and vectors", {
  for_all(
    a = anything_defined(),
    property = \(a)
      (is_tibble(a) || is_vector(a)) |> expect_true()
  )
})

test_that("anything_defined never generates undefined or empty values", {
  for_all(
    a = anything_defined(),
    property = \(a)
      (any(is.na(a)) || is_empty(a)) |> expect_false()
  )
})
