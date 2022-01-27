test_that("constant generates values equal to input argument", {
  for_all(
    a = any_vector(),
    property = \(a) {
      for_all(
        b = constant(a),
        property = \(b) expect_equal(a, b),
        tests = nested_tests()
      )
    },
    tests = nested_tests()
  )
})

test_that("constant can generate NULL values", {
  for_all(
    a = constant(NULL),
    property = \(a) expect_equal(a, NULL)
  )
})
