#' @param cols Number of columns of the generated data frame.
#'   If `cols` is a single number all data frames will have
#'   this number of columns. If `cols` is a numeric vector
#'   of length 2 it will produce data frames with columns
#'   between a minimum and maximum, inclusive. For example
#'   `cols = c(1L, 10L)` would produce data frames with
#'   columns between 1 and 10. To produce empty tibbles
#'   set `cols = 0L` or a range like `cols = c(0L, 10L)`.
