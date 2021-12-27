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

vectorize <- \(generator, len = len_()) {
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
  prob <-
    c(1 - frac_na, frac_na)

  hedgehog::gen.choice(generator, NA, prob = prob)
}

with_nan <- \(generator, frac_nan) {
  prob <-
    c(1 - frac_nan, frac_nan)

  hedgehog::gen.choice(generator, NaN, prob = prob)
}

with_inf <- \(generator, frac_inf) {
  prob <-
    c(1 - frac_inf, frac_inf)

  hedgehog::gen.choice(
    generator,
    hedgehog::gen.choice(-Inf, Inf),
    prob = prob
  )
}
