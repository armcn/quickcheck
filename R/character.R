#' Character generators
#'
#' A set of generators for character vectors.
#'
#' @template len
#' @template frac_na
#' @template frac_empty
#'
#' @examples
#' character_() |> show_example()
#' character_(len = 10L, frac_na = 0.5) |> show_example()
#' character_(len = 10L, frac_empty = 0.5) |> show_example()
#' @template generator
#' @export
character_ <- function(len = 1L, frac_na = 0, frac_empty = 0) {
  character_set <-
    bytes_to_character(32L:126L)

  qc_gen(\(len2 = len)
    replicate(1000L, random_string(character_set)) |>
      hedgehog::gen.element() |>
      replace_frac_with("", frac_empty) |>
      replace_frac_with(NA_character_, frac_na) |>
      vectorize(len2)
  )
}

bytes_to_character <- function(bytes) {
  as.raw(bytes) |>
    rawToChar() |>
    strsplit("") |>
    unlist()
}

random_string <- function(character_set) {
  character_set |>
    sample_vec(stats::runif(1L, 1L, 10L)) |>
    paste0(collapse = "")
}
