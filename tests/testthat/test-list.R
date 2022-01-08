test_that("list_ wraps a single generator in a list", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = list_(constant(a)),
        property = \(b) list(a) |> expect_equal(b),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("list_ wraps multiple generators in a list", {
  for_all(
    a = list_(any_atomic(), any_atomic()),
    property = \(a) {
      expect_true(
        is.list(a) && is.atomic(a[[1]]) && is.atomic(a[[2]])
      )
    }
  )
})

test_that("list_ maintains names", {
  for_all(
    a = list_(x = any_vector(), y = any_vector()),
    property = \(a) names(a) |> expect_equal(c("x", "y"))
  )
})
