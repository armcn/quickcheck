for_all <- \(..., property) {
  list(...) |>
    assert_generators_named() |>
    purrr::map(\(f) f()) |>
    hedgehog::forall(property = property)
}


assert_generators_named <- function(a) {
  list_names <-
    names(a)

  if (is.null(list_names) || any(list_names == ""))
    stop("All generators must be named", call. = FALSE)

  else
    a
}
