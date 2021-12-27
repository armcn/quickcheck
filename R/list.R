list_ <- \(...) {
  hedgehog::gen.with(list(...), as.list)
}

list_of <- \(generator, len = 1L) {
  vectorize(list(generator), len)
}
