% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{nearest_pts}
\alias{nearest_pts}
\title{Finds the nearest non-missing neighbors of a target point in a 2D matrix}
\arguments{
\item{x}{x-position of the point whose neighbors should be found within \code{in_mat}}

\item{y}{y-position of the point whose neighbors should be found within \code{in_mat}}

\item{in_mat}{a 2D matrix to search for neighbors of \code{pt}}

\item{neighbors}{the number of closest non-NA neighboring values to return within \code{in_mat}}

\item{radius}{the radius around \code{pt} to search. Default: 8.}

\item{ignore_zeros}{if TRUE, then zero is not a valid imputation value (since these are not data in NIfTIs)}
}
\value{
A vector of \code{neighbors} closest neighboring values around \code{pt}
}
\description{
Finds the nearest non-missing neighbors of a target point in a 2D matrix
}
\keyword{internal}
