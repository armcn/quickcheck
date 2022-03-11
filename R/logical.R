#' Logical generator
#'
#' A generator for logical vectors.
#'
#' @template len
#' @template any_na
#'
#' @examples
#' logical_() %>% show_example()
#' logical_(len = 10L, any_na = TRUE) %>% show_example()
#' @template generator
#' @export
logical_ <- function(len = c(1L, 10L), any_na = FALSE) {
  qc_gen(function(len2 = len)
    hedgehog::gen.element(c(TRUE, FALSE)) %>%
      replace_some_with(NA, any_na) %>%
      vectorize(len2)
  )
}
