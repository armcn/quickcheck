test_that("from_hedgehog converts a hedgehog to a quickcheck generator", {
  from_hedgehog(hedgehog::gen.element(1:100)) |>
    inherits("quickcheck_generator") |>
    expect_true()
})
