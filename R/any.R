#' @export
any_atomic <- \(len = 1L, frac_na = 0) {
  one_of(
    integer_(len, frac_na),
    double_(len, frac_na),
    character_(len, frac_na),
    logical_(len, frac_na)
  )
}
