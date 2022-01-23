test_that("any_undefined only produces undefined values", {
  for_all(
    a = any_undefined(),
    property = \(a) is_undefined(a) |> expect_true()
  )
})
