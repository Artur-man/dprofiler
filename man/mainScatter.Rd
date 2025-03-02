% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mainScatter.R
\name{mainScatter}
\alias{mainScatter}
\title{mainScatter}
\usage{
mainScatter(input = NULL, data = NULL, source = NULL)
}
\arguments{
\item{input, }{input params}

\item{data, }{dataframe that has log2FoldChange and log10padj values}

\item{source, }{for event triggering to select genes}
}
\description{
Creates the main scatter, volcano or MA plot to be displayed within the main
panel. A version of debrowser's mainScatterNew function with automated width and height
}
\examples{
    x <- mainScatter()
    
}
