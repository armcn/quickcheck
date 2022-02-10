test_suite_vector_generator(character_, is.character)

test_suite_vector_generator(character_letters, is.character)

test_suite_vector_generator(character_numbers, is.character)

test_suite_vector_generator(character_alphanumeric, is.character)

test_that("character_ can generate vectors with empty characters", {
  for_all(
    a = character_(len = 100L, any_empty = TRUE),
    property = \(a) is_empty_character(a) |> any() |> expect_true()
  )
})

test_that("character_letters generates letter strings", {
  for_all(
    a = character_letters(),
    property = \(a) grepl("^[A-Za-z]+$", a) |> all() |> expect_true()
  )
})

test_that("character_numbers generates number strings", {
  for_all(
    a = character_numbers(),
    property = \(a) grepl("^[0-9]+$", a) |> all() |> expect_true()
  )
})

test_that("character_alphanumeric generates alphanumeric strings", {
  for_all(
    a = character_alphanumeric(),
    property = \(a) grepl("^[A-Za-z0-9]+$", a) |> all() |> expect_true()
  )
})
