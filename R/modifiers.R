equal_length <- \(..., len = 1L) {
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
