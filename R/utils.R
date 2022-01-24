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

not_true <- function(a) {
  Negate(isTRUE)(a)
}

is_na_integer <- function(a) {
  is.integer(a) & is.na(a)
}

is_na_real <- function(a) {
  is.double(a) & is.na(a)
}

is_na_character <- function(a) {
  is.character(a) & is.na(a)
}

is_na_logical <- function(a) {
  is.logical(a) & is.na(a)
}

is_na_numeric <- function(a) {
  is_na_integer(a) | is_na_real(a)
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

is_zero <- function(a) {
  identical(a, 0) || identical(a, 0L)
}

is_infinite <- function(a) {
  is.atomic(a) && isTRUE(is.infinite(a))
}

is_nan <- function(a) {
  is.atomic(a) && isTRUE(is.nan(a))
}

is_na <- function(a) {
  isTRUE(is.na(a))
}

is_undefined <- function(a) {
  is.null(a) || is_infinite(a) || is_nan(a) || is_na(a)
}

is_vector <- function(a) {
  is.atomic(a) || is.list(a)
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
