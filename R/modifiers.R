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
