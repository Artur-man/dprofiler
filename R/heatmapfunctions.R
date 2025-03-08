#' heatmapServer
#'
#' Sets up shinyServer to be able to run heatmapServer interactively.
#' Adapted from debrowser::heatmapServer()
#'
#' @param input input 
#' @param output output 
#' @param session session 
#'
#' @examples
#'     x <- heatmapServer()
#'     
#' @export
#' 
heatmapServer <- function(input = NULL, output = NULL, session = NULL) {
  if (is.null(input)) return(NULL)
  
  updata <- reactiveVal()
  selected <- reactiveVal()
  expdata <- reactiveVal()
  observe({
    updata(callModule(debrowserdataload, "load", "Submit"))
  })
  observe({
    if(!is.null(updata()$load()$count))
      if (nrow(updata()$load()$count) > 1000){
        updateCheckboxInput(session, "mostvaried", value = TRUE)
        expdata(getMostVariedList(updata()$load()$count, 
                                  colnames(updata()$load()$count), input))
      }
    else
      expdata(updata()$load()$count)
  })
  
  observeEvent (input$Submit, {
    updateTabItems(session, "DEBrowserHeatmap", "Heatmap")
  })
  observe({
    if (!is.null(expdata())){
      withProgress(message = 'Creating plot', style = "notification", value = 0.1, {
        selected(callModule(dprofilerheatmap, "deresults", expdata()))
      })
    }
  })
  output$heatmap_hover <- renderPrint({
    if (!is.null(selected()) && !is.null(selected()$shgClicked()) && 
        selected()$shgClicked() != "")
      return(paste0("Clicked: ",selected()$shgClicked()))
    else
      return(paste0("Hovered:", selected()$shg()))
  })
  output$heatmap_selected <- renderPrint({
    if (!is.null(selected()))
      selected()$selGenes()
  })
  output$topn <- renderPrint({
    if (!is.null(input$topn))
      input$topn
  })
  output$mincount <- renderPrint({
    if (!is.null(input$mincount))
      input$mincount
  })
}

#' heatmapUI
#'
#' Creates a shinyUI to be able to run DEBrowser interactively.
#'
#' @param input input
#' @param output output 
#' @param session session
#'
#' @return the panel for heatmapUI;
#'
#' @examples
#'     x<-heatmapUI()
#'     
#' @export
#' 
heatmapUI <- function(input = NULL, output = NULL, session = NULL) {
  header <- dashboardHeader(
    title = "DEBrowser Heatmap"
  )
  sidebar <- dashboardSidebar(getJSLine(),
                              sidebarMenu(id="DEBrowserHeatmap",
                                          menuItem("Upload", tabName = "Upload"),
                                          menuItem("Heatmap", tabName = "Heatmap"),
                                          menuItem("Options", tabName = "Heatmap",
                                                   checkboxInput('mostvaried', 'Most Varied Set', value = FALSE),
                                                   conditionalPanel( (condition <- "input.mostvaried"),
                                                                     textInput("topn", "top-n", value = "500" ), 
                                                                     textInput("mincount", "total min count", value = "10" )),
                                                   plotSizeMarginsUI("deresults"),
                                                   heatmapControlsUI("deresults"))))
  
  body <- dashboardBody(
    tabItems(
      tabItem(tabName="Upload", dataLoadUI("load")),
      tabItem(tabName="Heatmap",  getHeatmapUI("deresults"),
              column(4,
                     verbatimTextOutput("heatmap_hover"),
                     verbatimTextOutput("heatmap_selected"),
                     verbatimTextOutput("topn"),
                     verbatimTextOutput("mincount")
              ))
    ))
  
  dashboardPage(header, sidebar, body, skin = "blue")
}