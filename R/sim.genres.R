#' Movie similarity based on genre
#'
#' The similarity of 2 movies A and B is measured based on their
#' potential common genre.
#'
#' @param movie_A character, one movie title from the movie database
#' @param movie_B character, another movie title from the movie database
#'
#' @return A scalar : the similarity based on genre
#'
#' @export
sim.genres <- function(movie_A, movie_B){

  movies <- moviesdemo::movies

  movie_A <- match.arg(movie_A, movies$title)
  movie_B <- match.arg(movie_B, movies$title)

  genres_A <- movies$genres[[which(movies$title == movie_A)]]
  genres_B <- movies$genres[[which(movies$title == movie_B)]]

  return(length(intersect(genres_A, genres_B)) / length(union(genres_A, genres_B)))
}