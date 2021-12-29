pipe <- \(...) {
  \(a)
    purrr::reduce(
      list(...),
      \(acc, f) f(acc),
      .init = a
    )
}

overlaps_zero <- \(left, right) {
  isTRUE(left <= 0L && right >= 0L)
}

vectorize <- \(generator, len = 1L) {
  if (length(len) == 1L)
    hedgehog::gen.c(generator, of = len)

  else
    hedgehog::gen.c(generator, len[1], len[2])
}

fail <- \(...) {
  stop(..., call. = FALSE)
}

with_empty <- \(generator, frac_empty) {
  prob <-
    c(1 - frac_empty, frac_empty)

  hedgehog::gen.choice(generator, "", prob = prob)
}

with_na <- \(generator, frac_na) {
  hedgehog::gen.map(
    \(a) if (stats::runif(1L) <= frac_na) NA else a,
    generator
  )
}

with_nan <- \(generator, frac_nan) {
  hedgehog::gen.map(
    \(a) if (stats::runif(1L) <= frac_nan) NaN else a,
    generator
  )
}

with_inf <- \(generator, frac_inf) {
  random_inf <-
    \() if (stats::runif(1L) <= 0.5) -Inf else Inf

  hedgehog::gen.map(
    \(a) if (stats::runif(1L) <= frac_inf) random_inf() else a,
    generator
  )
}
