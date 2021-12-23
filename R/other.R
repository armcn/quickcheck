one_of <- function(..., prob = NULL) {
  generators <-
    list(...) |>
      assert_not_empty() |>
      purrr::map(pipe(assert_quickcheck, generate))

  as_generator(
    \()
      purrr::exec(
        hedgehog::gen.choice,
        !!!generators,
        prob = prob
      )
  )
}


constant <- function(a) {
  pipe(
    assert_not_hedgehog,
    assert_not_quickcheck,
    hedgehog::gen.element,
    from_hedgehog
  )(a)
}


null_ <- function() {
  from_hedgehog(hedgehog::gen.choice(NULL))
}


from_hedgehog <- function(generator) {
  as_generator(\() generator)
}


assert_quickcheck <- function(a) {
  if (!is_quickcheck_generator(a))
    fail("Argument must be a quickcheck generator.")

  else
    a
}


assert_not_hedgehog <- function(a) {
  if (is_hedgehog_generator(a))
    fail("Argument can't be a hedgehog generator.")

  else
    a
}


assert_not_quickcheck <- function(a) {
  if (is_quickcheck_generator(a))
    fail("Argument can't be a quickcheck generator.")

  else
    a
}


assert_not_empty <- function(a) {
  if (is_empty(a))
    fail("Argument can't be empty.")

  else
    a
}


is_empty <- function(a) {
  isTRUE(length(a) == 0)
}


is_hedgehog_generator <- function(a) {
  isTRUE(class(a) == "hedgehog.internal.gen")
}


is_quickcheck_generator <- function(a) {
  isTRUE(class(a) == "quickcheck_generator")
}


generate <- function(generator) {
  generator()
}
