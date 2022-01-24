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
character_ <- function(len = c(1L, 10L), frac_na = 0, frac_empty = 0) {
  bytes_to_character(32L:126L) |>
    character_string(len, frac_na, frac_empty)
}

#' @rdname character_
#' @export
character_letter <- function(len = c(1L, 10L), frac_na = 0, frac_empty = 0) {
  c(letters, LETTERS) |>
    character_generator(len, frac_na, frac_empty)
}

#' @rdname character_
#' @export
character_word <- function(len = c(1L, 10L), frac_na = 0, frac_empty = 0) {
  c(letters, LETTERS) |>
    character_string(len, frac_na, frac_empty)
}

#' @rdname character_
#' @export
character_alphanumeric <- function(len = c(1L, 10L), frac_na = 0, frac_empty = 0) {
  c(letters, LETTERS, 0:9) |>
    character_string(len, frac_na, frac_empty)
}

character_string <- function(characters, len, frac_na, frac_empty) {
  replicate(1000L, random_string(characters)) |>
    character_generator(len, frac_na, frac_empty)
}

character_generator <- function(characters, len, frac_na, frac_empty) {
  qc_gen(\(len2 = len)
    hedgehog::gen.element(characters) |>
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
