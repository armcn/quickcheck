#' Equal length vector generator
#'
#' Generates equal length vectors contained in a list.
#'
#' @param ... A set of named or unnamed vector generators.
#' @template len
#'
#' @examples
#' equal_length(integer_(), double_()) |> show_example()
#' equal_length(a = logical_(), b = character_(), len = 5L) |> show_example()
#' @template generator
#' @export
equal_length <- function(..., len = c(1L, 10L)) {
  assert_all_modifiable_length(...)

  len_generator <-
    as_length_generator(len)

  generate_list <-
    \(a) purrr::map(list(...), \(f) f(len2 = a))

  qc_gen(\()
    hedgehog::gen.and_then(
      len_generator(),
      generate_list
    )
  )
}

vectorize <- function(generator, len = 1L) {
  if (is_zero(len))
    empty_vectors(generator)

  else if (length(len) == 1L)
    fixed_length_vectors(generator, len)

  else if (len[1L] == 0L)
    empty_or_variable_length_vectors(generator, len)

  else
    variable_length_vectors(generator, len)
}

empty_vectors <- function(generator) {
  hedgehog::gen.with(generator, \(a) a[0L])
}

fixed_length_vectors <- function(generator, len) {
  hedgehog::gen.c(generator, of = len)
}

variable_length_vectors <- function(generator, len) {
  hedgehog::gen.c(generator, len[1L], len[2L])
}

empty_or_variable_length_vectors <- function(generator, len) {
  hedgehog::gen.c(generator, len[1L] + 1L, len[2L]) |>
    replace_frac_empty(frac = 0.25)
}

replace_frac_empty <- function(generator, frac) {
  replace_frac <-
    \(a)
      if (stats::runif(1L) <= frac)
        a[0L]

      else
        a

  hedgehog::gen.with(generator, replace_frac)
}

replace_frac_with <- function(generator, replacement, frac) {
  replace_frac <-
    \(a)
      if (stats::runif(1L) <= frac)
        replacement

      else
        a

  hedgehog::gen.with(generator, replace_frac)
}

replace_some_with <- function(generator, replacement, replace) {
  if (replace)
    replace_frac_with(generator, replacement, frac = 0.25)

  else
    generator
}
