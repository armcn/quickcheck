#' Modify length of multiple generators
#'
#' This will set the length of multiple generators to be the
#' same.
#'
#' @param ... Generators
#' @template len
#'
#' @examples
#' equal_length(a = integer_(), b = character_(), len = 10L) |> show_example()
#' @template generator
#' @export
equal_length <- function(..., len = 1L) {
  vector_lengths <-
    if (length(len) == 1L)
      len

    else
      seq(len[1L], len[2L])

  hedgehog::gen.bind(
    \(a) purrr::map(list(...), vectorize, len = a),
    hedgehog::gen.element(vector_lengths)
  )
}

vectorize <- function(generator, len = 1L) {
  if (length(len) == 1L)
    hedgehog::gen.c(generator, of = len)

  else
    hedgehog::gen.c(generator, len[1], len[2])
}

with_empty <- function(generator, frac_empty) {
  prob <-
    c(1 - frac_empty, frac_empty)

  hedgehog::gen.choice(generator, "", prob = prob)
}

with_na <- function(generator, frac_na) {
  hedgehog::gen.map(
    \(a) if (stats::runif(1L) <= frac_na) NA else a,
    generator
  )
}

with_nan <- function(generator, frac_nan) {
  hedgehog::gen.map(
    \(a) if (stats::runif(1L) <= frac_nan) NaN else a,
    generator
  )
}

with_inf <- function(generator, frac_inf) {
  random_inf <-
    \() if (stats::runif(1L) <= 0.5) -Inf else Inf

  hedgehog::gen.map(
    \(a) if (stats::runif(1L) <= frac_inf) random_inf() else a,
    generator
  )
}
