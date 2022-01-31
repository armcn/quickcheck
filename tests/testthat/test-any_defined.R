test_that("any_defined generates data frames and vectors", {
  for_all(
    a = any_defined(),
    property = \(a)
      (is.data.frame(a) || is_vector(a)) |> expect_true()
  )
})

test_that("any_defined never generates undefined or empty values", {
  for_all(
    a = any_defined(),
    property = \(a)
      (any(is.na(a)) || is_empty(a)) |> expect_false()
  )
})
