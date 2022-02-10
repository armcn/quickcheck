#' Tibble generators
#'
#' Construct tibble generators in a similar way to `tibble::tibble`.
#'
#' @param ... A set of name-value pairs with the values being vector generators.
#' @template rows
#'
#' @examples
#' tibble_(a = integer_()) |> show_example()
#' tibble_(a = integer_(), b = character_(), rows = 5L) |> show_example()
#' @template generator
#' @export
tibble_ <- function(..., rows = c(1L, 10L)) {
  assert_all_modifiable_length(...)

  qc_gen(\()
    equal_length(..., len = rows)() |>
      hedgehog::gen.with(tibble::as_tibble)
  )
}

#' Random tibble generator
#'
#' @param ... A set of unnamed generators. The generated tibbles will be built
#'   with random combinations of these generators.
#' @template rows
#' @template cols
#'
#' @examples
#' tibble_of(logical_(), date_()) |> show_example()
#' tibble_of(any_atomic(), rows = 10L, cols = 5L) |> show_example()
#' @template generator
#' @export
tibble_of <- function(..., rows = c(1L, 10L), cols = c(1L, 10L)) {
  assert_all_modifiable_length(...)

  as_tibble <-
    \(a)
      suppressMessages(
        tibble::as_tibble(a, .name_repair = "unique")
      )

  expand_rows_and_cols <-
    \(dims)
      list(...) |>
        expand_rows(dims$rows) |>
        expand_cols(dims$cols)

  generate_tibble <-
    \(dims)
      expand_rows_and_cols(dims) |>
        hedgehog::gen.with(as_tibble)

  row_generator <-
    as_length_generator(rows)

  col_generator <-
    as_length_generator(cols)

  qc_gen(\()
    list_(rows = row_generator, cols = col_generator)() |>
      hedgehog::gen.and_then(generate_tibble)
  )
}

expand_cols <- function(generators, cols) {
  repeats <-
    if (length(cols) == 1L)
      cols

    else
      seq(cols[1L], cols[2L]) |> sample_vec()

  sample_cols <-
    \(a) generators[sample(1:length(generators), a, TRUE)]

  sample_cols(repeats)
}

expand_rows <- function(generators, rows) {
  repeats <-
    if (length(rows) == 1L)
      rows

    else
      seq(rows[1L], rows[2L]) |> sample_vec()

  expand_vectors <-
    \(a) purrr::map(generators, \(f) f(len2 = a))

  expand_vectors(repeats)
}
