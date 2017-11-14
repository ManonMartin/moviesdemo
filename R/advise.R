#' Advise movies based on another movie
#'
#' Documentation...
#'
#' @param similar_to character, movie title from the database.
#' @param how_many integer, how many movies to advise.
#' @param ... additional arguments.
#'
#' @export
advise.good.movie <- function(similar_to, how_many, ...){

  dots <- list(...)
  weights <- if(is.null(dots$weights)) rep(-1, 4) else dots$weights
  movies <- moviesdemo::movies
  names(weights) <- c("genre", "popularity", "rating", "production company")
  movie <- match.arg(similar_to, movies$title)

  if(!isTRUE(is.numeric(how_many) & (length(how_many) == 1))) {
    stop("Argument 'how_many' should be a number...")
  }

  for(x in names(weights)){

    index <- which(names(weights) == x)
    while(weights[index] < 0){
      weight <- readline(paste0("From 0 to 5, how important is the ", x, "?"))
      weight <- (if(isTRUE((as.numeric(weight) %in% 0:5) & (length(weight) == 1))){
        as.numeric(weight) } else -1)
      if(weight < 0){
        message("Try again, please provide an integer between 0 and 5...")
      }
      weights[index] <- weight
    }
  }

  indices <- (1:dim(movies)[1])[-which(movies$title == movie)]

  genre <- c(scale(log(sapply(indices, function(i) sim.genres(movie, movies$title[i])) + 0.01)))
  pop <- c(scale(log(movies$popularity[indices] + 0.01)))
  rating <- c(scale(movies$vote[indices]))
  producer <- c(scale(log(sapply(indices, function(i) sim.producers(movie, movies$title[i])) + 0.01)))

  total_scores <- weights[1] * genre + (weights[2] / 4) * pop +
                  (weights[3] / 4) * rating + (weights[4] / 2) * producer
  top_indices <- indices[order(total_scores, decreasing = T)[1:how_many]]

  return(list(selected = movie, to_watch = movies$title[top_indices], movie_ids = top_indices,
              scores = sort(total_scores, decreasing = T)[1:how_many]))

}