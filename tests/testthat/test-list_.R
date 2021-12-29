test_that("list_ wraps a single generator in a list", {
  for_all(
    a = integer_(),
    property = \(a) {
      for_all(
        b = list_(a),
        property = \(b) expect_equal(b, as.list(a)),
        tests = 10L
      )
    },
    tests = 10L
  )
})

test_that("list_ wraps multiple generators in a list", {
  for_all(
    a = list_(integer_(), character_()),
    property = \(a) {
      expect_true(
        is.list(a) &&
          is.integer(a[[1]]) &&
          is.character(a[[2]])
      )
    }
  )
})

test_that("list_ maintains names", {
  for_all(
    a = list_(x = double_(), y = list_(logical_())),
    property = \(a) expect_equal(names(a), c("x", "y"))
  )
})
