test_that("show_example returns an example", {
  constant("hello") %>% show_example() %>% expect_equal("hello")
})

test_that("show_example can show empty vectors", {
  constant(integer(length = 0L)) %>% show_example() %>% expect_equal(integer(0))
  constant(list()) %>% show_example() %>% expect_equal(list())
})
