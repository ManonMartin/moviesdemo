#' TMDb 4800 movie dataset
#'
#' Metadata on 4800 movies from The Movie Database (TMDb) from the Kaggle website.
#'
#' The variables are as follows:
#'    \describe{
#'      \item{title}{character, title of the film.}
#'      \item{genres}{string of characters, genres of the film.}
#'      \item{popularity}{numeric, popularity of the film in terms of views.}
#'      \item{vote}{numeric, voted rating of the film between 0 and 10.}
#'      \item{language}{factor, original language.}
#'      \item{producers}{string of characters, production companies.}
#'      \item{release}{date, release date of the film.}
#'      \item{runtime}{numeric, runtime in minutes.}
#'      \item{plot}{character, plot summary of the film.}
#'   }
#'
#' @format A data frame with 4800 rows and 9 variables.
#'
#' @source \url{https://www.kaggle.com/tmdb/tmdb-movie-metadata}
"movies"
