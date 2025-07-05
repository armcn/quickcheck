#' Factor generator
#'
#' A generator for factor vectors.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' factor_() %>% show_example()
#' factor_(len = 10L, any_na = TRUE) %>% show_example()
#' @template generator
#' @export
factor_ <- function(len = c(1L, 10L), any_na = FALSE) {
  qc_gen(function(len2 = len)
    character_(len = 1L) %>%
      as_hedgehog() %>%
      replace_some_with(NA, any_na) %>%
      hedgehog::gen.with(as.factor) %>%
      vectorize(len2)
  )
}
