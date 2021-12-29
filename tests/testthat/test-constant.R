test_that("generated values all equal argument", {
  for_all(
    a = integer_(),
    property = \(a) {
      for_all(
        b = constant(a),
        property = \(b) expect_equal(a, b),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("constant can generate NULL values", {
  for_all(
    a = constant(NULL),
    property = \(a) expect_equal(a, NULL)
  )
})
