% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/profiling.R
\name{getExpressionProfiles}
\alias{getExpressionProfiles}
\title{getExpressionProfiles}
\usage{
getExpressionProfiles(deres = NULL, data = NULL, columns = NULL, conds = NULL)
}
\arguments{
\item{deres}{DE results}

\item{data}{expression data}

\item{columns}{columns}

\item{conds}{conditions}
}
\description{
Given the gene expression matrix with multiple conditions, generate expression profiles.
}
\examples{
     x <- getExpressionProfiles()
    
}
