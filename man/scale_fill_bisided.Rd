% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sugar.R
\name{scale_fill_bisided}
\alias{scale_fill_bisided}
\title{scale for plotting separate color gradients for positive and negative values}
\usage{
scale_fill_bisided(
  name = ggplot2::waiver(),
  neg_scale = scale_fill_distiller(palette = "Blues", direction = 1),
  pos_scale = scale_fill_distiller(palette = "Reds"),
  symmetric = TRUE
)
}
\arguments{
\item{name}{the scale name to be printed in the legend (above positive scale)}

\item{neg_scale}{a scale_fill_* object used for negative values}

\item{pos_scale}{a scale_fill_* object used for positive values}

\item{symmetric}{if TRUE, the limits of the positive scale will equal the inverse limits of
the negative scale. Said differently, this makes the positive and negative scales symmetric}
}
\value{
a \code{ggplot2} scale of type \code{ScaleContinuous} that includes negative and positive fill
scales internally in the \verb{$neg_scale} and \verb{$pos_scale} elements
}
\description{
scale for plotting separate color gradients for positive and negative values
}
\details{
Note that this will absolutely not work as a general purpose ggplot2 scale!
The positive/negative combination is achieved by adding two layers/geoms behind the
scenes with different color scale.
}
