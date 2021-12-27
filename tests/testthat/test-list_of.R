test_that("generates lists", {
  for_all(
    a = list_of(integer_()),
    property = \(a) expect_true(is.list(a))
  )
})


test_that("generates lists with length 1", {
  for_all(
    a = list_of(integer_()),
    property = \(a) expect_equal(length(a), 1L)
  )
})


test_that("generates values equal to calling `as.list`", {
  for_all(
    a = list_of(constant(1L)),
    b = constant(1L),
    property = \(a, b) expect_equal(a, as.list(b))
  )
})
