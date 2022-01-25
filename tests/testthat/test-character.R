test_suite_vector_generator(character_, is.character)

test_suite_vector_generator(character_letter, is.character)

test_suite_vector_generator(character_word, is.character)

test_suite_vector_generator(character_alphanumeric, is.character)

test_that("character_ can generate vectors with empty characters", {
  for_all(
    a = character_(len = 10L, frac_empty = 1),
    property = \(a) is_empty_character(a) |> all() |> expect_true()
  )
})

test_that("character_letter generates single letters", {
  for_all(
    a = character_letter(),
    property = \(a) (a %in% c(letters, LETTERS)) |> all() |> expect_true()
  )
})

test_that("character_word generates words", {
  for_all(
    a = character_word(),
    property = \(a) grepl("[A-Za-z]+", a) |> all() |> expect_true()
  )
})

test_that("character_alphanumeric generates alphanumeric strings", {
  for_all(
    a = character_alphanumeric(),
    property = \(a) grepl("[A-Za-z0-9]+", a) |> all() |> expect_true()
  )
})
