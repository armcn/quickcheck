one_of <- \(..., prob = NULL) {
  hedgehog::gen.choice(..., prob = prob)
}


constant <- \(a) {
  hedgehog::gen.element(a)
}


null_ <- \() {
  hedgehog::gen.choice(NULL)
}
