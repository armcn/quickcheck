vectorize <- function(generator, len = 1L) {
  if (is_zero(len))
    generator |> hedgehog::gen.with(\(a) a[0L])

  else if (length(len) == 1L)
    hedgehog::gen.c(generator, of = len)

  else if (len[1L] == 0L)
    hedgehog::gen.c(generator, len[1L] + 1L, len[2L]) |>
      replace_frac_empty(frac = 0.5)

  else
    hedgehog::gen.c(generator, len[1L], len[2L])
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
