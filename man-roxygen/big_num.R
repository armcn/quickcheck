#' @param big_num Should integers or doubles near the
#' maximum size be included? This may cause problems because
#' if the result of a computation results in a number
#' larger than the maximum an integer will be silently
#' coerced to a double and a double will return `Inf`.
