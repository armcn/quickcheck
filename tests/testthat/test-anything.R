test_that("anything generates data frames, vectors, or undefined values", {
  for_all(
    a = anything(),
    property = \(a)
      or(is.data.frame, is_vector, is_undefined)(a) |> expect_true()
  )
})

test_that("anything can exclude empty vectors and data frames", {
  for_all(
    a = anything(any_empty = FALSE),
    property = \(a)
      or(is_empty_vector, is_empty_data_frame)(a) |> expect_false()
  )
})

test_that("anything can exclude undefined values", {
  for_all(
    a = anything(any_undefined = FALSE),
    property = \(a) is_undefined(a) |> expect_false()
  )
})
