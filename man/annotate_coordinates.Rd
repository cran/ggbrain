% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sugar.R
\name{annotate_coordinates}
\alias{annotate_coordinates}
\title{Adds the coordinate labels to each panel based on the location of the slice along the slicing axis (e.g., z = 15)}
\usage{
annotate_coordinates(x = "right", y = "bottom", ...)
}
\arguments{
\item{x}{the x position of the coordinate label. If numeric, it is assumed to be the pixel position along the x axis (e.g., 26).
In addition, convenience values of \code{"left"}, \code{"right"}, or \code{"q[1-100]"} can be used to look up the left-most,
right-most, or quantile-based positions along the x axis.}

\item{y}{the y position of the coordinate label. If numeric, it is assumed to be the pixel position along the y axis (e.g., 26).
In addition, convenience values of 'top', \code{"bottom"}, or \code{"q[1-100]"} can be used to look up the top-most, bottom-most,
or quantile-based positions along the y axis.}

\item{...}{any other arguments to ggplot2::annotate, which will be passed through to each panel}
}
\value{
a \code{ggb} object with the action 'add_annotations', used in a \code{ggbrain} addition chain
}
\description{
Adds the coordinate labels to each panel based on the location of the slice along the slicing axis (e.g., z = 15)
}
