test_suite_vector_generator <- function(generator, .p) {
  test_generator_predicate(generator, .p)
  test_generator_default_not_any_na(generator)
  test_generator_empty_vectors(generator, .p)
  test_generator_default_vector_length(generator)
  test_generator_vector_length(generator)
  test_generator_vector_length_range(generator)
  test_generator_with_na(generator, .p)
}

test_suite_list_of_generator <- function(generator, .p) {
  test_generator_predicate(generator, .p)
  test_generator_empty_vectors(generator, .p)
  test_generator_default_vector_length(generator)
  test_generator_vector_length(generator)
  test_generator_vector_length_range(generator)
}

test_generator_predicate <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates correct values"
    ),
    {
      for_all(
        a = generator(),
        property = \(a) .p(a) |> testthat::expect_true()
      )
    }
  )
}

test_generator_default_not_any_na <- function(generator) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " doesn't generate NAs by default"
    ),
    {
      for_all(
        a = generator(),
        property = \(a) {
          unlist(a) |> is.na() |> any() |> testthat::expect_false()
        }
      )
    }
  )
}

test_generator_empty_vectors <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " can generate empty vectors"
    ),
    {
      for_all(
        a = generator(len = 0L),
        property = \(a) .p(a) |> testthat::expect_true()
      )

      for_all(
        a = generator(len = 0L),
        property = \(a) length(a) |> testthat::expect_equal(0L)
      )
    }
  )
}

test_generator_default_vector_length <- function(generator) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates vectors with lengths between 1 and 10 inclusive"
    ),
    {
      for_all(
        a = generator(),
        property = \(a) {
          testthat::expect_true(length(a) >= 1L && length(a) <= 10L)
        }
      )
    }
  )
}

test_generator_vector_length <- function(generator) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates vectors of a specific length"
    ),
    {
      for_all(
        len = integer_bounded(0L, 10L, len = 1L),
        property = \(len) {
          for_all(
            a = generator(len = len),
            property = \(a) length(a) |> testthat::expect_equal(len),
            tests = 10L
          )
        },
        tests = 10L
      )
    }
  )
}

test_generator_vector_length_range <- function(generator) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates vectors within a range of lengths"
    ),
    {
      for_all(
        min = integer_bounded(0L, 5L, len = 1L),
        max = integer_bounded(5L, 10L, len = 1L),
        property = \(min, max) {
          for_all(
            a = generator(len = c(min, max)),
            property = \(a) {
              testthat::expect_true(length(a) >= min && length(a) <= max)
            },
            tests = 10L
          )
        },
        tests = 10L
      )
    }
  )
}

test_generator_with_na <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " can generate vectors with NAs"
    ),
    {
      for_all(
        a = generator(frac_na = 1),
        property = \(a) {
          unlist(a) |> is.na() |> all() |> testthat::expect_true()
        }
      )
    }
  )
}
