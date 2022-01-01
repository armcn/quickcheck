#' Generate the same value every time
#'
#' @param a Any R object
#'
#' @examples
#' constant(NULL) |> show_example()
#' @template generator
#' @export
constant <- function(a) {
  qc_gen(\(...)
    hedgehog::gen.choice(a)
  )
}
