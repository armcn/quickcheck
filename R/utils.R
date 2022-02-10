qc_gen <- function(a) {
  structure(a, class = "quickcheck_generator")
}

sample_vec <- function(a, n = 1L) {
  if (n_distinct(a) == 1L)
    a[[1L]]

  else
    sample(a, size = n, replace = TRUE)
}

as_length_generator <- function(a) {
  if (length(a) == 1L)
    constant(a)

  else
    integer_bounded(a[1], a[2], len = 1L)
}

eval_functions <- function(...) {
  purrr::map(list(...), \(f) f())
}

equals <- function(a, b) {
  a == b
}

overlaps_zero <- function(left, right) {
  isTRUE(left <= 0L && right >= 0L)
}

is_posixct <- function(a) {
  inherits(a, "POSIXct")
}

is_date <- function(a) {
  inherits(a, "Date")
}

is_data_frame <- function(a) {
  identical(class(a), "data.frame")
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
  if (is_empty_list(a))
    TRUE

  else {
    flattened <-
      unlist(a, recursive = FALSE)

    lengths_equal <-
      length(a) == length(flattened)

    lengths_equal && is.atomic(flattened)
  }
}

is_homogeneous_list <- function(a) {
  if (is_empty_list(a))
    TRUE

  else {
    is_homogeneous <-
      purrr::map(a, class) |>
        n_distinct() |>
        equals(1)

    is.list(a) && is_homogeneous
  }
}

is_flat_homogeneous_list <- function(a) {
  is_flat_list(a) && is_homogeneous_list(a)
}

is_empty_data_frame <- function(a) {
  if (is.data.frame(a))
    isTRUE(nrow(a) == 0L)

  else
    FALSE
}

is_empty_vector <- function(a) {
  isTRUE(!is.null(a) && length(a) == 0L)
}

is_empty_list <- function(a) {
  is_empty_vector(a) && is.list(a)
}

is_dev_version <- function() {
  version_length <-
    utils::packageDescription("quickcheck") |>
      purrr::pluck("Version") |>
      strsplit("\\.") |>
      purrr::pluck(1L) |>
      length()

  version_length > 3L
}

tests <- function() {
  getOption("quickcheck.tests", 100L)
}

nested_tests <- function() {
  tests() |> sqrt() |> round()
}

assert_modifiable_length <- function(generator) {
  has_modifiable_length <-
    formals(generator) |>
      names() |>
      purrr::has_element("len2")

  if (has_modifiable_length)
    TRUE

  else
    stop(
      "Generator arguments must be quickcheck vector generators.",
      call. = FALSE
    )
}

assert_all_modifiable_length <- function(...) {
  list(...) |> purrr::map(assert_modifiable_length)
}

or <- function(...) {
  funs <-
    list(...)

  \(a) {
    for (i in seq_along(funs))
      if (isTRUE(funs[[i]](a)))
        return(TRUE)

    FALSE
  }
}

n_distinct <- function(a) {
  purrr::compose(length, unique)(a)
}
