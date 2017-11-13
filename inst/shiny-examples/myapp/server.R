server <- function(input, output, session){

  updateSelectizeInput(session, 'movie', choices = movies$title, server = TRUE)

  max_movies <- eventReactive(eventExp = input$newpar, valueExpr = isolate(input$how_many))

  select_movies <- eventReactive(eventExp = input$newpar, valueExpr = {
    advise.good.movie(isolate(input$movie), isolate(input$how_many), weights = c(isolate(input$genre),
                                                                                 isolate(input$pop), isolate(input$rating), isolate(input$producer)))
  })

  output$selected <- renderUI({
    HTML(paste0("<font size = 6px><b> ", "Selected movie: ", select_movies()$selected, " </b></font>"))
  })

  ##### Create divs######
  output$advised_movies <- renderUI({
    text_output_list <- lapply(1:max_movies(), function(i) {
      name <- paste("textbox_", i, sep="")
      htmlOutput(name)
    })
    do.call(tagList, text_output_list)
  })

  observe({
    lapply(1:max_movies(), function(i){
      output[[paste("textbox_", i, sep="")]] <- renderUI({
        str1 <- paste0("<font size = 4px><b> ", i, ". ", select_movies()$to_watch[i], ", (similarity score: ",
                       round(select_movies()$scores[i], digits = 2), ")", " </b></font>")
        str2 <- paste0("<font size=2px><i>", movies$plot[select_movies()$movie_ids[i]], "</font></i>")
        str3 <- paste0("<font size=2px>", "Language: ", movies$language[select_movies()$movie_ids[i]],
                       ", Release date: ", movies$release[select_movies()$movie_ids[i]], ", Length: ",
                       movies$runtime[select_movies()$movie_ids[i]], "min.", "</font>")

        HTML(paste('<br/>', str1, '<br/>', str2, '<br/>', str3, '<br/><br/>', sep = ""))

      })
    })
  })
}
