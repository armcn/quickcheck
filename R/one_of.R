#' Randomly choose between generators
#'
#' @param ... A set of unnamed generators.
#' @param prob A vector of probability weights for obtaining the elements of the
#'   vector being sampled.
#'
#' @examples
#' one_of(integer_(), character_()) %>% show_example()
#' one_of(constant(NULL), logical_(), prob = c(0.1, 0.9)) %>% show_example()
#' @template generator
#' @export
one_of <- function(..., prob = NULL) {
  qc_gen(function()
    do.call(
      purrr::partial(hedgehog::gen.choice, prob = prob),
      eval_functions(...)
    )
  )
}
