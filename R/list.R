#' List generator
#'
#' This will generate lists with contents corresponding to the values generated
#' by the input generators.
#'
#' @param ... Quickcheck generators
#'
#' @examples
#' list_(integer_(), logical_()) |> show_example()
#' list_(a = any_vector(), b = any_vector()) |> show_example()
#' @template generator
#' @export
list_ <- function(...) {
  qc_gen(\()
    eval_functions(...) |>
      hedgehog::gen.with(as.list)
  )
}

#' Variable length list generator
#'
#' This will generate lists with all values coming from a single input generator.
#'
#' @param generator Quickcheck generator
#' @template len
#'
#' @examples
#' list_of(integer_(), len = 10L) |> show_example()
#' @template generator
#' @export
list_of <- function(generator, len = 1L) {
  qc_gen(\(len2 = len)
    vectorize(list(generator()), len2)
  )
}
