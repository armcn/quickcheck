test_that("any_undefined only produces undefined values", {
  for_all(
    a = any_undefined(),
    property = function(a) is_undefined(a) %>% expect_true()
  )
})
