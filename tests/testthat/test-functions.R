context("moviesdemo functions")

test_that("Output similarity measures", {

    ## Test output sim.genres()
    expect_is(sim.genres(movies$title[1], movies$title[2]), "numeric")
    expect_equal(sim.genres(movies$title[1], movies$title[1]), 1)
    expect_error(sim.genres(NA, movies$title[1]))

    ## Test output sim.producers()
    expect_is(sim.producers(movies$title[1], movies$title[2]), "numeric")
    expect_equal(sim.producers(movies$title[1], movies$title[1]), 1)
    expect_error(sim.producers(NA, movies$title[1]))

})

test_that("Output advise.good.movie function", {

    out <- advise.good.movie(movies$title[1], 5, weights = rep(1,4))

    expect_output(str(out), "List of 4")
    expect_match(out[[1]], movies$title[1])
    expect_equal(length(out[[2]]), 5)
    expect_is(out[[2]], "character")
    expect_error(advise.good.movie(movies$title[1], NA),
                 "Argument 'how_many' should be a number...")

})

