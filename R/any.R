#' Atomic vector generator
#'
#' Generate vectors of integer, double, character, logical, date, POSIXct, hms,
#' or factors.
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
  qc_gen(\(len2 = len)
    one_of(
      integer_(len2, frac_na),
      double_(len2, frac_na),
      character_(len2, frac_na),
      logical_(len2, frac_na),
      date_(len2, frac_na),
      posixct_(len2, frac_na),
      hms_(len2, frac_na),
      factor_(len2, frac_na)
    )()
  )
}

#' Flat list generator
#'
#' Generate lists where each element is an atomic vector with a length of 1.
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
#' any_list(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_list <- function(len = 1L, frac_na = 0) {
  atomic <-
    any_atomic(c(1L, 10L), frac_na)

  qc_gen(\(len2 = len)
    one_of(
      any_flat_list(len2, frac_na),
      list_of(atomic, len2),
      list_of(list_(a = atomic, b = atomic), len2)
    )()
  )
}

#' Random vector generator
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
  qc_gen(\(len2 = len)
    one_of(
      any_atomic(len2, frac_na),
      any_list(len2, frac_na)
    )()
  )
}

#' Random tibble generator
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
