vectorize <- function(generator, len = 1L) {
  if (length(len) == 1L)
    hedgehog::gen.c(generator, of = len)

  else
    hedgehog::gen.c(generator, len[1], len[2])
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
