% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{sort_mat}
\alias{sort_mat}
\title{Sort Matrix by Column}
\arguments{
\item{x}{A \code{matrix} to sort}

\item{col}{A \code{int} that indicates the column the matrix should sort by.}
}
\value{
The matrix sorted by values in the specified column.
}
\description{
Sorts a given matrix by a specific column while retain the elements in each row.
}
\details{
This functions sorts a matrix based on one column, keeping the rows together.
Note that \code{col} should be a zero-based index of \code{x} (i.e., first column is 0).
}
\keyword{internal}
