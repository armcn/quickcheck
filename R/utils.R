qc_gen <- function(a) {
  structure(a, class = "quickcheck_generator")
}

sample_vec <- function(a, n = 1L) {
  if (dplyr::n_distinct(a) == 1L)
    a[[1L]]

  else
    sample(a, size = n, replace = TRUE)
}

eval_functions <- function(...) {
  purrr::map(list(...), \(f) f())
}

overlaps_zero <- function(left, right) {
  isTRUE(left <= 0L && right >= 0L)
}

and <- function(...) {
  \(b)
    purrr::reduce(
      list(...),
      \(acc, a) acc & a(b),
      .init = TRUE
    )
}

or <- function(...) {
  \(b)
    purrr::reduce(
      list(...),
      \(acc, a) acc | a(b),
      .init = FALSE
    )
}

is_na_integer <- function(a) {
  and(is.na, is.integer)(a)
}

is_na_real <- function(a) {
  and(is.na, is.double)(a)
}

is_na_character <- function(a) {
  and(is.na, is.character)(a)
}

is_na_logical <- function(a) {
  and(is.na, is.logical)(a)
}

is_na_numeric <- function(a) {
  or(is_na_integer, is_na_real)(a)
}

is_posixct <- function(a) {
  inherits(a, "POSIXct")
}

is_date <- function(a) {
  inherits(a, "Date")
}

is_tibble <- function(a) {
  inherits(a, "tbl_df")
}

is_empty_character <- function(a) {
  a == ""
}

is_flat_list <- function(a) {
  flattened <-
    unlist(a, recursive = FALSE)

  lengths_equal <-
    length(a) == length(flattened)

  lengths_equal && is.atomic(flattened)
}
