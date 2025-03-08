% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/condSelect.R
\name{selectConditions}
\alias{selectConditions}
\title{selectConditions}
\usage{
selectConditions(Dataset = NULL, metadata = NULL, session = NULL, input = NULL)
}
\arguments{
\item{Dataset, }{used dataset}

\item{metadata, }{metadatatable to select from metadata}

\item{session, }{session}

\item{input, }{input params}
}
\description{
Selects user input conditions, multiple if present, to be used in DE analysis.
}
\examples{
    x<- selectConditions()
    
}
