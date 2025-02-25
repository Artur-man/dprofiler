% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/profiling.R
\name{getProfileScoreDetails}
\alias{getProfileScoreDetails}
\title{getProfileScoreDetails}
\usage{
getProfileScoreDetails(
  output = NULL,
  session = NULL,
  tablename = NULL,
  data = NULL,
  modal = NULL,
  highlight = FALSE
)
}
\arguments{
\item{output, }{output}

\item{session, }{session}

\item{tablename, }{table name}

\item{data, }{matrix data}

\item{modal, }{if it is true, the matrix is going to be in a modal}

\item{highlight}{if it is true, numerical columns are highlighted}
}
\description{
Details and scores of the profiling analysis
}
\examples{
    x <- getProfileScoreDetails()
    
}
