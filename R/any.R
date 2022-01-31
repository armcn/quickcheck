#' Any R object generator
#'
#' Generate any R object. This doesn't actually generate any possible object,
#' just the most common ones, namely atomic vectors, lists, data.frames,
#' tibbles, data.tables, and undefined values like `NA`, `NULL`, `Inf`, and
#' `NaN`.
#'
#' @examples
#' anything() |> show_example()
#' @template generator
#' @export
anything <- function() {
  one_of(
    any_vector(len = c(0L, 10L), frac_na = 0.1),
    any_data_frame_object(rows = c(0L, 10L), cols = c(0L, 10L), frac_na = 0.1),
    any_undefined()
  )
}

#' Any R object generator with no undefined values
#'
#' Generate any R object which isn't an undefined value or doesn't contain
#' undefined values. This doesn't actually generate any possible object,
#' just the most common ones, namely atomic vectors, lists, and tibbles.
#' None of the objects created will include undefined values like `NA`, `NULL`,
#' `Inf`, `NaN`, or be empty vectors or tibbles.
#'
#' @examples
#' any_defined() |> show_example()
#' @template generator
#' @export
any_defined <- function() {
  one_of(
    any_vector(len = c(1L, 10L)),
    any_data_frame_object(rows = c(1L, 10L), cols = c(1L, 10L))
  )
}

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
any_atomic <- function(len = c(1L, 10L), frac_na = 0) {
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
any_flat_list <- function(len = c(1L, 10L), frac_na = 0) {
  flat_list_of(any_atomic(frac_na = frac_na), len)
}

#' Flat homogeneous list generator
#'
#' Generate lists where each element is an atomic scalar of the same type.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' any_flat_homogeneous_list() |> show_example()
#' any_flat_homogeneous_list(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_flat_homogeneous_list <- function(len = c(1L, 10L), frac_na = 0) {
  qc_gen(\(len2 = len)
    one_of(
      flat_list_of(integer_(frac_na = frac_na), len2),
      flat_list_of(double_(frac_na = frac_na), len2),
      flat_list_of(character_(frac_na = frac_na), len2),
      flat_list_of(logical_(frac_na = frac_na), len2),
      flat_list_of(date_(frac_na = frac_na), len2),
      flat_list_of(posixct_(frac_na = frac_na), len2),
      flat_list_of(hms_(frac_na = frac_na), len2),
      flat_list_of(factor_(frac_na = frac_na), len2)
    )()
  )
}

#' Random list generator
#'
#' Generate random lists containing other lists or atomic vectors of variable
#' lengths.
#'
#' @template len
#' @template frac_na
#'
#' @examples
#' any_list() |> show_example()
#' any_list(len = 10L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_list <- function(len = c(1L, 10L), frac_na = 0) {
  atomic <-
    any_atomic(c(1L, 10L), frac_na)

  qc_gen(\(len2 = len)
    one_of(
      any_flat_list(len2, frac_na),
      any_flat_homogeneous_list(len2, frac_na),
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
any_vector <- function(len = c(1L, 10L), frac_na = 0) {
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

#' Random data frame generator
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
    any_atomic(frac_na = frac_na),
    rows = rows,
    cols = cols
  )
}

#' Random data.table generator
#'
#' Generate random data.tables.
#'
#' @template rows
#' @template cols
#' @template frac_na
#'
#' @examples
#' any_data.table() |> show_example()
#' any_data.table(rows = 10L) |> show_example()
#' any_data.table(cols = 5L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_data.table <- function(rows = c(1L, 10L), cols = c(1L, 10L), frac_na = 0) {
  data.table_of(
    any_vector(frac_na = frac_na),
    rows = rows,
    cols = cols
  )
}

#' Random data frame classed object generator
#'
#' Generate random data frame objects.
#'
#' @template rows
#' @template cols
#' @template frac_na
#'
#' @examples
#' any_data_frame_object() |> show_example()
#' any_data_frame_object(rows = 10L) |> show_example()
#' any_data_frame_object(cols = 5L, frac_na = 0.5) |> show_example()
#' @template generator
#' @export
any_data_frame_object <- function(rows = c(1L, 10L), cols = c(1L, 10L), frac_na = 0) {
  one_of(
    any_tibble(rows = rows, cols = cols, frac_na = frac_na),
    any_data_frame(rows = rows, cols = cols, frac_na = frac_na),
    any_data.table(rows = rows, cols = cols, frac_na = frac_na)
  )
}

#' Undefined value generator
#'
#' Generate undefined values. In this case undefined values include `NA`,
#' `NA_integer_`, `NA_real_`, `NA_character_`, `NA_complex_`, `NULL`, `-Inf`,
#' `Inf`, and `NaN`. Values generated are always scalars.
#'
#' @examples
#' any_undefined() |> show_example()
#' @template generator
#' @export
any_undefined <- function() {
  one_of(
    constant(NULL),
    constant(-Inf),
    constant(Inf),
    constant(NaN),
    constant(NA),
    constant(NA_integer_),
    constant(NA_real_),
    constant(NA_character_),
    constant(NA_complex_)
  )
}
