#' Any R object generator
#'
#' Generate any R object. This doesn't actually generate any possible object,
#' just the most common ones, namely atomic vectors, lists, data.frames,
#' tibbles, data.tables, and undefined values like `NA`, `NULL`, `Inf`, and
#' `NaN`.
#'
#' @param any_empty Whether empty vectors or data frames should be allowed.
#' @param any_undefined Whether undefined values should be allowed.
#'
#' @examples
#' anything() |> show_example()
#' @template generator
#' @export
anything <- function(any_empty = TRUE, any_undefined = TRUE) {
  size <-
    if (any_empty)
      c(0L, 10L)

    else
      c(1L, 10L)

  vector_generator <-
    any_vector(
      len = size,
      any_na = any_undefined
    )

  tibble_generator <-
    any_tibble(
      rows = size,
      cols = size,
      any_na = any_undefined
    )

  data_frame_generator <-
    any_data_frame(
      rows = size,
      cols = size,
      any_na = any_undefined
    )

  data.table_generator <-
    any_data.table(
      rows = size,
      cols = size,
      any_na = any_undefined
    )

  undefined_generator <-
    if (any_undefined)
      any_undefined()

    else
      NULL

  generator_list <-
    purrr::compact(
      list(
        vector_generator,
        tibble_generator,
        data_frame_generator,
        data.table_generator,
        undefined_generator
      )
    )

  do.call(one_of, generator_list)
}

#' Any atomic vector generator
#'
#' Generate vectors of integer, double, character, logical, date, POSIXct, hms,
#' or factors.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' any_atomic() |> show_example()
#' any_atomic(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
any_atomic <- function(len = c(1L, 10L), any_na = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      integer_(len2, any_na),
      double_(len2, any_na),
      character_(len2, any_na),
      logical_(len2, any_na),
      date_(len2, any_na),
      posixct_(len2, any_na),
      hms_(len2, any_na),
      factor_(len2, any_na)
    )()
  )
}

#' Any flat list generator
#'
#' Generate lists in which each element is an atomic scalar.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' any_flat_list() |> show_example()
#' any_flat_list(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
any_flat_list <- function(len = c(1L, 10L), any_na = FALSE) {
  flat_list_of(any_atomic(any_na = any_na), len)
}

#' Any flat homogeneous list generator
#'
#' Generate lists in which each element is an atomic scalar of the same class.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' any_flat_homogeneous_list() |> show_example()
#' any_flat_homogeneous_list(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
any_flat_homogeneous_list <- function(len = c(1L, 10L), any_na = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      flat_list_of(integer_(any_na = any_na), len2),
      flat_list_of(double_(any_na = any_na), len2),
      flat_list_of(character_(any_na = any_na), len2),
      flat_list_of(logical_(any_na = any_na), len2),
      flat_list_of(date_(any_na = any_na), len2),
      flat_list_of(posixct_(any_na = any_na), len2),
      flat_list_of(hms_(any_na = any_na), len2),
      flat_list_of(factor_(any_na = any_na), len2)
    )()
  )
}

#' Any list generator
#'
#' Generate lists containing lists or atomic vectors.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' any_list() |> show_example()
#' any_list(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
any_list <- function(len = c(1L, 10L), any_na = FALSE) {
  atomic <-
    any_atomic(c(1L, 10L), any_na)

  qc_gen(\(len2 = len)
    one_of(
      any_flat_list(len2, any_na),
      any_flat_homogeneous_list(len2, any_na),
      list_of(atomic, len2),
      list_of(list_(a = atomic, b = atomic), len2)
    )()
  )
}

#' Any vector generator
#'
#' Generate atomic vectors or lists.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' any_vector() |> show_example()
#' any_vector(len = 10L, any_na = TRUE) |> show_example()
#' @template generator
#' @export
any_vector <- function(len = c(1L, 10L), any_na = FALSE) {
  qc_gen(\(len2 = len)
    one_of(
      any_atomic(len2, any_na),
      any_list(len2, any_na)
    )()
  )
}

#' Any tibble generator
#'
#' Generate tibbles.
#'
#' @template rows
#' @template cols
#' @template any_na
#'
#' @examples
#' any_tibble(rows = 3L, cols = 3L) |> show_example()
#' @template generator
#' @export
any_tibble <- function(rows = c(1L, 10L),
                       cols = c(1L, 10L),
                       any_na = FALSE) {
  tibble_of(
    any_vector(any_na = any_na),
    rows = rows,
    cols = cols
  )
}

#' Any data frame generator
#'
#' Generate data.frames.
#'
#' @template rows
#' @template cols
#' @template any_na
#'
#' @examples
#' any_data_frame(rows = 3L, cols = 3L) |> show_example()
#' @template generator
#' @export
any_data_frame <- function(rows = c(1L, 10L),
                           cols = c(1L, 10L),
                           any_na = FALSE) {
  data_frame_of(
    any_atomic(any_na = any_na),
    rows = rows,
    cols = cols
  )
}

#' Any data.table generator
#'
#' Generate data.tables.
#'
#' @template rows
#' @template cols
#' @template any_na
#'
#' @examples
#' any_data.table(rows = 3L, cols = 3L) |> show_example()
#' @template generator
#' @export
any_data.table <- function(rows = c(1L, 10L),
                           cols = c(1L, 10L),
                           any_na = FALSE) {
  data.table_of(
    any_vector(any_na = any_na),
    rows = rows,
    cols = cols
  )
}

#' Any undefined value generator
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
