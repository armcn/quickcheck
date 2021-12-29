#' Atomic vector generator
#'
#' Generate vectors of integer, double, character, or
#' logical.
#'
#' @template len
#' @template frac_na
#'
#' @template generator
#' @export
any_atomic <- \(len = 1L, frac_na = 0) {
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
#' @template generator
#' @export
any_flat_list <- \(len = 1L, frac_na = 0) {
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
#' @template generator
#' @export
any_list <- \(len = 1L, frac_na = 0) {
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
#' @template generator
#' @export
any_vector <- \(len = 1L, frac_na = 0) {
  one_of(any_atomic(len, frac_na), any_list(len, frac_na))
}
