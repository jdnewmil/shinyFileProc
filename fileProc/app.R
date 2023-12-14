#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyFiles)

roots <- c( root = "../data" )

muck <- function( dta ) {
  dta$newcol <- "New"
  dta
}

new_muck_name <- function( old_name ) {
  sprintf( "%s_muck.csv", tools::file_path_sans_ext( old_name ) )
}

write_muck <- function( dta, fpath ) {
  write.csv( dta, fpath )
  nrow( dta )
}

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("FileProcTest")
    , shinyFilesButton(
      "file1"
      , label = "File select"
      , title = "Please select a CSV file"
      , multiple = FALSE
    )
    , textOutput( "file1summary" )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  shinyFileChoose(
    input
    , "file1"
    , root = roots
    , filetypes = c( "", "csv" )
  )
  fnamer <- reactive({
    req( input$file1 )
    finfo <- parseFilePaths(roots = roots, selection = input$file1 )
    if ( 0 == nrow( finfo ) ) {
      NULL
    } else {
      finfo$datapath
    }
  })
  dtar <- reactive({
    req(fnamer)
    read.csv( fnamer() )
  })
  fname_muckr <- reactive({
    new_muck_name( fnamer() )
  })
  
  output$file1summary <- renderText({
    sprintf( "lines read: %d", write_muck( muck( dtar() ), fname_muckr() ) )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
