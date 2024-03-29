% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tibble.R
\name{tibble_}
\alias{tibble_}
\title{Tibble generators}
\usage{
tibble_(..., rows = c(1L, 10L))
}
\arguments{
\item{...}{A set of name-value pairs with the values being vector generators.}

\item{rows}{Number of rows of the generated data frame.
If \code{rows} is a single number all data frames will have
this number of rows. If \code{rows} is a numeric vector of
length 2 it will produce data frames with rows between
a minimum and maximum, inclusive. For example
\code{rows = c(1L, 10L)} would produce data frames with rows
between 1 and 10. To produce empty tibbles set \code{rows = 0L}
or a range like \code{rows = c(0L, 10L)}.}
}
\value{
A \code{quickcheck_generator} object.
}
\description{
Construct tibble generators in a similar way to \code{tibble::tibble}.
}
\examples{
tibble_(a = integer_()) \%>\% show_example()
tibble_(a = integer_(), b = character_(), rows = 5L) \%>\% show_example()
}
