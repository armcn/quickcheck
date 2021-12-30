#' Atomic vector generator
#'
#' Generate vectors of integer, double, character, or
#' logical.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' any_atomic() |> show_example()
#' any_atomic(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_atomic <- function(len = 1L, frac_na = 0) {
  one_of(
    integer_(len, frac_na),
    double_(len, frac_na),
    character_(len, frac_na),
    logical_(len, frac_na),
    date_(len, frac_na),
    posixct_(len, frac_na),
    factor_(len, frac_na)
  )
}

#' Flat list generator
#'
#' Generate lists where each item has a length of 1.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' any_flat_list() |> show_example()
#' any_flat_list(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_flat_list <- function(len = 1L, frac_na = 0) {
  list_of(any_atomic(1L, frac_na), len)
}

#' Random list generator
#'
#' Generate random lists containing other lists or atomic
#' vectors of variable lengths.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' any_list() |> show_example()
#' any_list(len = 10L, frac_na = 0.5)
#' @template generator
#' @export
any_list <- function(len = 1L, frac_na = 0) {
  atomic <-
    any_atomic(c(1L, 10L), frac_na)

  one_of(
    any_flat_list(len, frac_na),
    list_of(atomic, len),
    list_of(list_(a = atomic, b = atomic), len)
  )
}

#' Any vector generator
#'
#' Generate random atomic vectors or lists.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' any_vector() |> show_example()
#' any_vector(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_vector <- function(len = 1L, frac_na = 0) {
  one_of(
    any_atomic(len, frac_na),
    any_list(len, frac_na)
  )
}

#' Any data frame generator
#'
#' Generate random data frames.
#'
#' @template rows
#' @template cols
#' @template frac_na
#'
#' @examples
#' any_data_frame() |> show_example()
#' any_data_frame(rows = 10L) |> show_example()
#' any_data_frame(cols = 5L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_data_frame <- function(rows = c(1L, 10L), cols = c(1L, 10L), frac_na = 0) {
  data_frame_of(
    any_vector(frac_na = frac_na),
    rows = rows,
    cols = cols
  )
}

#' Any tibble generator
#'
#' Generate random tibbles.
#'
#' @template rows
#' @template cols
#' @template frac_na
#'
#' @examples
#' any_tibble() |> show_example()
#' any_tibble(rows = 10L) |> show_example()
#' any_tibble(cols = 5L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_tibble <- function(rows = c(1L, 10L), cols = c(1L, 10L), frac_na = 0) {
  tibble_of(
    any_vector(frac_na = frac_na),
    rows = rows,
    cols = cols
  )
}
