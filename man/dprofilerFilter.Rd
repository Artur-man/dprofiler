% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/additionalServers.R
\name{dprofilerFilter}
\alias{dprofilerFilter}
\title{dprofilerFilter}
\usage{
dprofilerFilter(
  input = NULL,
  output = NULL,
  session = NULL,
  parent_session = NULL,
  uploadeddata = NULL
)
}
\arguments{
\item{input, }{input variables}

\item{output, }{output objects}

\item{session, }{session}

\item{parent_session, }{parent_session}

\item{uploadeddata, }{loaded data}
}
\value{
main plot
}
\description{
Module to filter low count genes/regions, adapted from debrowser::debrowserlowcountfilter
}
\examples{
    x <- dprofilerFilter()

}
