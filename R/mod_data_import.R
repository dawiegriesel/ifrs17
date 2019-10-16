# Module UI
  
#' @title   mod_data_import_ui and mod_data_import_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_data_import
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_data_import_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        fileInput(ns("file1"), "Choose CSV File",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),
        checkboxInput(ns("header"), "Header", TRUE)
      ),
      mainPanel(
        tableOutput(ns("contents"))
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_data_import
#' @export
#' @keywords internal
    
mod_data_import_server <- function(input, output, session){
  ns <- session$ns
  options(shiny.maxRequestSize=30*1024^2)
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
  })
  
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
 
