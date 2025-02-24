#' batchEffectUI
#' Creates a panel to coorect batch effect
#'
#' @param id, namespace id
#' @return panel
#' @examples
#'     x <- batchEffectUI("batcheffect")
#'
#' @export
#'
batchEffectUI <- function (id) {
  ns <- NS(id)
  list(
    fluidRow(
      shinydashboard::box(title = "Batch Effect Correction and Normalization",
                          solidHeader = TRUE, status = "info",  width = 12, 
                          fluidRow(
                            column(5,div(style = 'overflow: scroll',
                                         tableOutput(ns("uploadSummary")),
                                         DT::dataTableOutput(ns("sampleDetails"))),
                                   uiOutput(ns("beforebatchtable"))
                            ),
                            column(2,
                                   shinydashboard::box(title = "Options",
                                                       solidHeader = TRUE, status = "info",
                                                       width = 12, 
                                                       normalizationMethods(id),
                                                       batchMethod(id),
                                                       uiOutput(ns("batchfields")),
                                                       actionButtonDE(ns("submitBatchEffect"), label = "Submit", styleclass = "primary")
                                   )
                            ),
                            column(5,div(style = 'overflow: scroll', 
                                         tableOutput(ns("filteredSummary")),
                                         DT::dataTableOutput(ns("filteredDetails"))),
                                   uiOutput(ns("afterbatchtable"))
                            )
                          ),
                          actionButtonDE(ns("goDE"), "Go to Comp. Phenotypic Profiling", styleclass = "primary"),
                          actionButtonDE(ns("gotodeconvolute"), "Go to Compositional Profiling", styleclass = "primary"),
                          actionButtonDE(ns("gotoprofile"), "Go to Comparative Profiling", styleclass = "primary")
                          ),
      shinydashboard::box(title = "Plots",
                          solidHeader = TRUE, status = "info",  width = 12, 
                          fluidRow(column(1, div()),
                                   tabsetPanel( id = ns("batchTabs"),
                                                tabPanel(id = ns("PCA"), "PCA",
                                                         column(5, debrowser::getPCAPlotUI(ns("beforeCorrectionPCA"))),
                                                         column(2,  
                                                                shinydashboard::box(title = "PCA Controls",
                                                                                    solidHeader = T, status = "info",  width = 12, 
                                                                                    tabsetPanel( id = ns("pcacontrols"),
                                                                                                 tabPanel ("Before",
                                                                                                           pcaPlotControlsUI(ns("beforeCorrectionPCA"))),
                                                                                                 tabPanel ( "After",
                                                                                                            pcaPlotControlsUI(ns("afterCorrectionPCA")))))),
                                                         column(5, debrowser::getPCAPlotUI(ns("afterCorrectionPCA")))
                                                ),
                                                tabPanel(id = ns("IQR"), "IQR",
                                                         column(5, debrowser::getIQRPlotUI(ns("beforeCorrectionIQR"))),
                                                         column(2, div()),
                                                         column(5, debrowser::getIQRPlotUI(ns("afterCorrectionIQR")))
                                                ),
                                                tabPanel(id = ns("Density"), "Density",
                                                         column(5, debrowser::getDensityPlotUI(ns("beforeCorrectionDensity"))),
                                                         column(2, div()),
                                                         column(5, debrowser::getDensityPlotUI(ns("afterCorrectionDensity")))
                                                )
                                   )
                          )
      )
    ), getPCAcontolUpdatesJS())
}

#' dataLCFUI
#' Creates a panel to filter low count genes and regions
#'
#' @param id, namespace id
#' @return panel
#' @examples
#'     x <- dataLCFUI("lcf")
#'
#' @export
#'
dataLCFUI<- function (id) {
  ns <- NS(id)
  list(
    fluidRow(
      shinydashboard::box(title = "Low Count Filtering",
                          solidHeader = TRUE, status = "info",  width = 12, 
                          fluidRow(
                            column(5,div(style = 'overflow: scroll',
                                         tableOutput(ns("uploadSummary")),
                                         DT::dataTableOutput(ns("sampleDetails"))),
                                   uiOutput(ns("loadedtable"))
                            ),
                            column(2,
                                   shinydashboard::box(title = "Filtering Methods",
                                                       solidHeader = TRUE, status = "info",
                                                       width = 12, 
                                                       lcfMetRadio(id),
                                                       uiOutput(ns("cutoffLCFMet")),
                                                       actionButtonDE(ns("submitLCF"), label = "Filter", styleclass = "primary")
                                   )
                            ),
                            column(5,div(style = 'overflow: scroll',
                                         tableOutput(ns("filteredSummary")),
                                         DT::dataTableOutput(ns("filteredDetails"))),
                                   uiOutput(ns("filteredtable"))
                            )
                          ),
                          column(12, 
                                 fluidRow(
                                   actionButtonDE(ns("Batch"), label = "Batch Effect Correction", styleclass = "primary"),
                                   actionButtonDE(ns("goDE"), "Go to Comp. Pheno. Profiling", styleclass = "primary"),
                                   actionButtonDE(ns("gotodeconvolute"), "Go to Compositional Profiling", styleclass = "primary"),
                                   actionButtonDE(ns("gotoprofile"), "Go to Comparative Profiling", styleclass = "primary")
                                 )
                          )
      ),
      shinydashboard::box(title = "Histograms",
                          solidHeader = TRUE, status = "info",  width = 12, 
                          fluidRow(
                            column(6,debrowser::histogramControlsUI(ns("beforeFiltering")),
                                   debrowser::getHistogramUI(ns("beforeFiltering"))),
                            column(6,debrowser::histogramControlsUI(ns("afterFiltering")),
                                   debrowser::getHistogramUI(ns("afterFiltering")))
                          ))
    ))
}

#' dprofilerboxmainplot
#'
#' Module for a box plot that can be used alongside DEanalysis and heatmaps. Adapted from debrowserboxmainplot().
#' 
#' @param input input variables
#' @param output output variables
#' @param session session
#' @param data a matrix with expression values
#' @param cols columns
#' @param conds conditions
#' @param key the gene or region name
#'
#' @examples
#'     x <- dprofilerboxmainplot()
#'     
#' @export
#'     
dprofilerboxmainplot <- function (input = NULL, output = NULL, session = NULL, data = NULL, 
                                  cols = NULL, conds = NULL, key = NULL) 
{
  if (is.null(data)) 
    return(NULL)
  output$BoxMain <- renderPlotly({
    debrowser::getBoxMainPlot(data, cols, conds, key, title = "", 
                   input)
  })
  output$BoxMainUI <- renderUI({
    column(4,
           shinydashboard::box(collapsible = TRUE, title = "Gene Box Plots", 
                               status = "primary", solidHeader = TRUE, width = NULL, 
                               draggable = TRUE, plotlyOutput(session$ns("BoxMain")))
    )
  })
}

#' dprofilerbarmainplot
#'
#' Module for a bar plot that can be used in data prep, main plots low count removal modules or any desired module. 
#' Adapted from dprofilerbarmainplot().
#' 
#' @param input input variables
#' @param output output variables
#' @param session session
#' @param data a matrix with expression values
#' @param cols columns
#' @param conds conditions
#' @param key the gene or region name
#'
#' @examples
#'     x <- dprofilerbarmainplot()
#'     
#' @export
#' 
dprofilerbarmainplot <- function (input = NULL, output = NULL, session = NULL, data = NULL, cols = NULL, conds = NULL, 
                                  key = NULL) 
{
  if (is.null(data)) 
    return(NULL)
  output$BarMainUI <- renderUI({
    column(4,
           shinydashboard::box(collapsible = TRUE, title = "Gene Bar Plot", 
                               status = "primary", solidHeader = TRUE, width = NULL, 
                               draggable = TRUE, plotlyOutput(session$ns("BarMain")))
    )
  })
  output$BarMain <- renderPlotly({
    debrowser::getBarMainPlot(data, cols, conds, key, title = "", 
                   input = input)
  })
}