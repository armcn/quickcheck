#' @param rows Number of rows of the generated data frame.
#'   If `rows` is a single number all data frames will have
#'   this number of rows. If `rows` is a numeric vector of
#'   length 2 it will produce data frames with rows between
#'   a minimum and maximum, inclusive. For example
#'   `rows = c(1L, 10L)` would produce data frames with rows
#'   between 1 and 10. To produce empty tibbles set `rows = 0L`
#'   or a range like `rows = c(0L, 10L)`.
