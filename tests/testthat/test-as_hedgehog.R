test_that("as_hedgehog converts a quickcheck to a hedgehog generator", {
  repeat_test(
    property = function() {
      as_hedgehog(anything()) %>%
        inherits("hedgehog.internal.gen") %>%
        expect_true()
    }
  )
})
