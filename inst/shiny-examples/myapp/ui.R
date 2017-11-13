ui <- fluidPage(

  titlePanel("Demo movie-selection app"),

  sidebarLayout(

    sidebarPanel(

      selectizeInput("movie", label = "Choose a movie", selected = "Avatar", choices = NULL,
                     multiple = FALSE, options = list(placeholder = 'Type a movie name')),
      numericInput("how_many", "How many movies to advise?", 5, 1, 100, 1),
      tags$hr(),
      sliderInput("genre", "How important is the genre?", value = 5, min = 0, max = 5, step = 1),
      sliderInput("pop", "How important is the popularity?", value = 1, min = 0, max = 5, step = 1),
      sliderInput("rating", "How important is the rating?", value = 1, min = 0, max = 5, step = 1),
      sliderInput("producer", "How important is the production company?", value = 1, min = 0, max = 5, step = 1),
      tags$hr(),
      actionButton("newpar", label = "Update movies!")

    ),

    mainPanel(
      htmlOutput("selected"),
      tags$hr(),
      uiOutput("advised_movies")
    )
  )
)
