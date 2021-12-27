#' @export
for_all <- \(...,
             property,
             tests = get_tests(),
             size = get_size(),
             shrinks = get_shrinks(),
             discards = get_discards()) {
  list(...) |>
    assert_generators_named() |>
    hedgehog::forall(
      property = property,
      tests = tests,
      size.limit = size,
      shrink.limit = shrinks,
      discard.limit = discards
    )
}

get_tests <- \() {
  getOption("quickcheck.tests", 100L)
}

get_size <- \() {
  getOption("quickcheck.size", 50L)
}

get_shrinks <- \() {
  getOption("quickcheck.shrinks", 100L)
}

get_discards <- \() {
  getOption("quickcheck.discards", 100L)
}

assert_generators_named <- \(a) {
  list_names <-
    names(a)

  if (is.null(list_names) || any(list_names == ""))
    stop("All generators must be named", call. = FALSE)

  else
    a
}
