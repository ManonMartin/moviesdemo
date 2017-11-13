#' Movie similarity based on genre
#'
#' Documentation...
#'
#' @export
sim.genres <- function(movie_A, movie_B){

  movie_A <- match.arg(movie_A, movies$title)
  movie_B <- match.arg(movie_B, movies$title)

  genres_A <- movies$genres[[which(movies$title == movie_A)]]
  genres_B <- movies$genres[[which(movies$title == movie_B)]]

  return(length(intersect(genres_A, genres_B)) / length(union(genres_A, genres_B)))
}

#' Movie similarity based on production companies
#'
#' Documentation...
#'
#' @export
sim.producers <- function(movie_A, movie_B){

  movie_A <- match.arg(movie_A, movies$title)
  movie_B <- match.arg(movie_B, movies$title)

  producers_A <- movies$producers[[which(movies$title == movie_A)]]
  producers_B <- movies$producers[[which(movies$title == movie_B)]]

  return(length(intersect(producers_A, producers_B)) / length(union(producers_A, producers_B)))
}
