test_that("list_ wraps a single generator in a list", {
  for_all(
    a = anything(),
    property = \(a) {
      for_all(
        b = list_(constant(a)),
        property = \(b) list(a) |> expect_equal(b),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("list_ wraps multiple generators in a list", {
  for_all(
    a = list_(any_atomic(), any_atomic()),
    property = \(a)
      is.list(a) && is.atomic(a[[1]]) && is.atomic(a[[2]]) |> expect_true()
  )
})

test_that("list_ maintains names", {
  for_all(
    a = list_(x = anything(), y = anything()),
    property = \(a) names(a) |> expect_equal(c("x", "y"))
  )
})
