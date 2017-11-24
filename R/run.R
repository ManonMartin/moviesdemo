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

#' Open html slides SMCS course
#'
#' This function opens the course slides.
#'
#' @importFrom utils browseURL
#' @export
openSlides <- function() {
  slidesFile <- system.file("smcs-slides", "smcs_Rpackages.html", package = "moviesdemo")
  if (slidesFile == "") {
    stop("Could not find correct file. Try re-installing `moviesdemo`.", call. = FALSE)
  }

  utils::browseURL(slidesFile)
}
