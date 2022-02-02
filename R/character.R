#' Character generators
#'
#' A set of generators for character vectors.
#'
#' @template len
#' @template any_na
#' @template any_empty
#'
#' @examples
#' character_() |> show_example()
#' character_(len = 10L, any_na = TRUE) |> show_example()
#' character_(len = 10L, any_empty = TRUE) |> show_example()
#' @template generator
#' @export
character_ <- function(len = c(1L, 10L),
                       any_na = FALSE,
                       any_empty = FALSE) {
  bytes_to_character(32L:126L) |>
    character_string(len, any_na, any_empty)
}

#' @rdname character_
#' @export
character_letters <- function(len = c(1L, 10L),
                              any_na = FALSE,
                              any_empty = FALSE) {
  c(letters, LETTERS) |>
    character_string(len, any_na, any_empty)
}

#' @rdname character_
#' @export
character_numbers <- function(len = c(1L, 10L),
                              any_na = FALSE,
                              any_empty = FALSE) {
  as.character(0:9) |>
    character_string(len, any_na, any_empty)
}

#' @rdname character_
#' @export
character_alphanumeric <- function(len = c(1L, 10L),
                                   any_na = FALSE,
                                   any_empty = FALSE) {
  c(letters, LETTERS, 0:9) |>
    character_string(len, any_na, any_empty)
}

character_string <- function(characters, len, any_na, any_empty) {
  replicate(1000L, random_string(characters)) |>
    character_generator(len, any_na, any_empty)
}

character_generator <- function(characters, len, any_na, any_empty) {
  qc_gen(\(len2 = len)
    hedgehog::gen.element(characters) |>
      replace_some_with("", any_empty) |>
      replace_some_with(NA_character_, any_na) |>
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
