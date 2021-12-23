with_length <- function(generator,
                        from = NULL,
                        to = NULL,
                        of = 1) {
  \()
    if (!is.null(from))
      with_length_bounded(generator, from = from, to = to)

    else
      with_length_of(generator, of = of)
}


with_length_bounded <- function(generator, from, to) {
  if (from <= 0)
    stop("`from` must be a positive number")

  else if (to <= 0)
    stop("`to` must be a positive number")

  else if (from > to)
    stop("`from` must be less than `to`")

  else
    hedgehog::gen.c(generator(), from = from, to = to)
}


with_length_of <- function(generator, of) {
  if (of <= 0)
    stop("`of` must be a positive number")

  else
    hedgehog::gen.c(generator(), of = of)
}
