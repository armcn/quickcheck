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
  list_of_anything <-
    purrr::partial(generator, generator = anything())

  test_generator_predicate(list_of_anything, .p)
  test_generator_empty_vectors(list_of_anything, .p)
  test_generator_default_vector_length(list_of_anything)
  test_generator_vector_length(list_of_anything)
  test_generator_vector_length_range(list_of_anything)
}

test_suite_flat_list_of_generator <- function(generator, .p) {
  list_of_any_atomic <-
    purrr::partial(generator, generator = any_atomic())

  test_generator_predicate(list_of_any_atomic, .p)
  test_generator_empty_vectors(list_of_any_atomic, .p)
  test_generator_default_vector_length(list_of_any_atomic)
  test_generator_vector_length(list_of_any_atomic)
  test_generator_vector_length_range(list_of_any_atomic)
}

test_suite_data_frame_generator <- function(generator, .p) {
  single_col_generator <-
    purrr::partial(generator, col_a = any_vector())

  test_generator_data_frame_wraps_vector(generator, .p)
  test_generator_empty_data_frame(single_col_generator, .p)
  test_generator_default_rows(single_col_generator, .p)
  test_generator_specific_rows(single_col_generator, .p)
  test_generator_range_rows(single_col_generator, .p)
  test_generator_non_modifiable_length(generator)
}

test_suite_data_frame_of_generator <- function(generator, .p) {
  single_col_generator <-
    purrr::partial(
      generator,
      any_vector(),
      cols = 1L
    )

  test_generator_data_frame_of_wraps_vector(single_col_generator, .p)
  test_generator_default_rows(single_col_generator, .p)
  test_generator_specific_rows(single_col_generator, .p)
  test_generator_range_rows(single_col_generator, .p)
  test_generator_non_modifiable_length(generator)
}

test_suite_any_data_frame_generator <- function(generator, .p) {
  test_generator_empty_data_frame(generator, .p)
  test_generator_default_rows(generator, .p)
  test_generator_specific_rows(generator, .p)
  test_generator_range_rows(generator, .p)
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
        property = function(a) .p(a) %>% testthat::expect_true()
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
        property = function(a) {
          unlist(a) %>% is.na() %>% any() %>% testthat::expect_false()
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
        property = function(a) .p(a) %>% testthat::expect_true()
      )

      for_all(
        a = generator(len = 0L),
        property = function(a) length(a) %>% testthat::expect_equal(0L)
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
        property = function(a) {
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
        property = function(len) {
          for_all(
            a = generator(len = len),
            property = function(a) length(a) %>% testthat::expect_equal(len),
            tests = nested_tests()
          )
        },
        tests = nested_tests()
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
        property = function(min, max) {
          for_all(
            a = generator(len = c(min, max)),
            property = function(a) {
              testthat::expect_true(length(a) >= min && length(a) <= max)
            },
            tests = nested_tests()
          )
        },
        tests = nested_tests()
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
        a = generator(len = 100L, any_na = TRUE),
        property = function(a) {
          unlist(a) %>% is.na() %>% any() %>% testthat::expect_true()
        },
        tests = 10L
      )
    }
  )
}

test_generator_data_frame_wraps_vector <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " wraps a vector in a data frame subclass"
    ),
    {
      for_all(
        a = generator(
          col_a = any_vector(len = c(0L, 10L), any_na = TRUE)
        ),
        property = function(a)
          (is_vector(a$col_a) && .p(a)) %>% testthat::expect_true()
      )
    }
  )
}

test_generator_data_frame_of_wraps_vector <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " wraps a vector in a data frame subclass"
    ),
    {
      for_all(
        a = generator(),
        property = function(a)
          (is_vector(a[[1L]]) && .p(a)) %>% testthat::expect_true()
      )
    }
  )
}

test_generator_empty_data_frame <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " can generate empty data frames"
    ),
    {
      for_all(
        a = generator(rows = 0L),
        property = function(a)
          (nrow(a) == 0L && .p(a)) %>% testthat::expect_true()
      )
    }
  )
}

test_generator_default_rows <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates data frame subclasses with rows from 1 to 10 by default"
    ),
    {
      for_all(
        a = generator(),
        property = function(a)
          (nrow(a) >= 1L && nrow(a) <= 10L) %>% testthat::expect_true()
      )
    }
  )
}

test_generator_specific_rows <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates data frame subclasses with a specific number of rows"
    ),
    {
      for_all(
        rows = integer_bounded(left = 0L, right = 5L, len = 1L),
        property = function(rows)
          for_all(
            a = generator(rows = rows),
            property = function(a) nrow(a) %>% testthat::expect_identical(rows),
            tests = nested_tests()
          ),
        tests = nested_tests()
      )
    }
  )
}

test_generator_range_rows <- function(generator, .p) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " generates data frame subclasses with a range of rows"
    ),
    {
      for_all(
        min = integer_bounded(left = 0L, right = 5L, len = 1L),
        max = integer_bounded(left = 5L, right = 10L, len = 1L),
        property = function(min, max)
          for_all(
            a = generator(rows = c(min, max)),
            property = function(a)
              (nrow(a) >= min && nrow(a) <= max) %>% testthat::expect_true(),
            tests = nested_tests()
          ),
        tests = nested_tests()
      )
    }
  )
}

test_generator_non_modifiable_length <- function(generator) {
  testthat::test_that(
    paste0(
      deparse(substitute(generator)),
      " fails if generator arguments don't have modifiable lengths"
    ),
    {
      non_modifiable_length <-
        any_vector() %>% as_hedgehog() %>% from_hedgehog()

      repeat_test(
        property = function() {
          generator(col_a = non_modifiable_length) %>% testthat::expect_error()
        }
      )
    }
  )
}
