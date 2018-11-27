#' Run Shiny app
#'
#' This function runs the Shiny application included with the package.
#'
#' @export
runMovieApp <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "moviesdemo")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `moviesdemo`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
