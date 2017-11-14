<style>
.small-code pre code {
  font-size: 1.3em;
}
</style>

SMCS course: write and publish R-packages with RStudio
========================================================
author: Manon Martin & Joris Chau
date: November 2017
width: 1600
height: 1000
font-family: 'Helvetica'

Install Git
========================================================

<!-- ### Download Git -->

* on Windows: http://git-scm.com/download/win
* on OS X: http://git-scm.com/download/mac
* on Debian/Ubuntu: `sudo apt-get install git-core`
* on other Linux distros: http://git-scm.com/download/linux

Clone existing Git repository (1)
========================================================



* In Rstudio: `File > New Project > Version Control > Git`
* Repository URL: `https://github.com/JorisChau/moviesdemo.git`
* Select path where to clone package on local pc

Note: we do **not** install the package, we *only* download files from Github to local pc.

<img src="pictures/Fig1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="55%" style="display: block; margin: auto;" />

Clone existing Git repository (2)
========================================================

* In Git shell type: `git clone https://github.com/JorisChau/moviesdemo.git`
* In RStudio: `File > New Project > Existing Directory`
* Select path to cloned package on local pc

<img src="pictures/Fig2.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="60%" style="display: block; margin: auto;" />

NAMESPACE*
========================================================

### Motivating example

```r
nrow
```

```
# function (x) 
# dim(x)[1L]
# <bytecode: 0x562e3b2e8450>
# <environment: namespace:base>
```

Now what happens if we overwrite `dim()` in the global environment?


```r
dim <- function(x) c(1, 1)
dim(mtcars)
```

```
# [1] 1 1
```

Does `nrow()` still work?


```r
nrow(mtcars)
```

```
# [1] 32
```

NAMESPACE
=========================================================

### Motivation
The NAMESPACE file decides which functions/methods to **import** from other packages and which functions/methods to **export** from the created package.

We write **imports** and **exports** through Roxygen comments in our `.R` files.

### Several useful Roxygen comments
* `#' @export`, exports functions
* `#' @importFrom`, imports speficic functions, e.g. `#' @importFrom shiny runApp`
* `#' @import`, imports all functions in a package, e.g. `#' @import shiny`
* See http://r-pkgs.had.co.nz/namespace.html for more details <br>
<br>

### Workflow
1. Add Roxygen comments to `.R` files
2. Run `devtools::document()` (or `Ctrl/Cmd + Shift + D` in RStudio) to Roxygenize files
3. Repeat until correct functions are imported and exported

NAMESPACE
=========================================================

**Tip**: Roxygenize also on `Build and Reload` (`Ctrl/Cmd + Shift + B` in RStudio)

* In RStudio: `Build > Configure Build Tools > Build Tools`

<img src="pictures/Fig3.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="55%" style="display: block; margin: auto;" />


Data
========================================================

### Including data in the package
* Exported data available to the user is stored in `data/`.
* Internal data *not* available to the user is stored in `R/sysdata.rda`
* Raw data can be stored in `inst/extdata`

### Exported/Internal data

```r
# setwd(/path/to/package_root)
x <- sample(1000)
devtools::use_data(x) ## exported data, writes x to data/x.rda
devtools::use_data(x, internal = T) ## internal data, writes x to R/sysdata.rda
rm(x)
load("data/x.rda")
load("R/sysdata.rda")
```

**Tip**: set `LazyData:true` in `DESCRIPTION` file, (datasets do not occupy memory until used).

### Documenting datasets

Objects in `data/` are always exported and therefore *need* documentation. Documenting data is (almost) the same as documenting a function. Document the name of the dataset and save it in `R/`, e.g. `R/data.R`. See http://r-pkgs.had.co.nz/data.html for more details and how to include other types of data.

Data
========================================================

### Excerpt from `R/data.R`


```r
#' TMDb 4800 movie dataset
#'
#' Metadata on 4800 movies from The Movie Database (TMDb) from the Kaggle website.
#'
#' The variables are as follows:
#'    \itemize{
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
```

**Note**: view the resulting help file (after documentation `Ctrl/Cmd + Shift + D`) e.g. with `?movies`.


Automated Testing
=========================================================

### Motivation
Automate tests to see if code is (still) working properly. Advantages: confidently make changes without breaking other functionalities, easier to locate bugs, etc.

### Setup

```r
# install.packages('testthat')
# setwd(/path/to/package_root)
devtools::use_testthat() ## creates necessary files/folders
```

### Test structure
* An **expectation** starts with `expect_` and describes expected result of a computation
* A **test** created with `test_that()` groups multiple expectations to test a (simple) function
* A **file** groups toghether multiple similar tests and is named via `context()`

### Workflow
* Modify code or tests
* Test package with `Ctrl/Cmd + Shift + T` or `devtools::test()` or `Build > Test Package`
* Repeat until all tests pass

Automated Testing
=========================================================

### Several useful `expect_` functions

* `expect_equal()` uses `all.equal()` for equality with some numerical error:


```r
library(testthat)
expect_equal(10, 10) ## passes
expect_equal(10, 10 + 1E-7) ## passes
expect_equal(10, 11) ## errors
```

* `expect_identical()` uses `identical()` for exact equality
* Other `expect_` functions:


```r
## Match character vectors
string <- "Testing is fun!"
expect_match(string, "Testing") ## case-sensitive

## Inspect printed output
expect_output(str(list(1:10, letters)), "List of 2")
expect_message(message("Hello"), "Hello")
expect_warning(log(-1), "NaNs produced")
expect_error(1 / "a", "non-numeric argument")
```

* See http://r-pkgs.had.co.nz/tests.html for more details and writing your own `expect_`'s

Automated Testing
=========================================================

### Excerpt from `tests > testthat > test-functions.R`


```r
context("moviesdemo functions")

test_that("Output similarity measures", {

    ## Test output sim.genres()
    expect_is(sim.genres(movies$title[1], movies$title[2]), "numeric")
    expect_equal(sim.genres(movies$title[1], movies$title[1]), 1)
    expect_error(sim.genres(NA, movies$title[1]))

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
```

Vignettes
=========================================================

### Motivation
Vignettes are long-form tutorials written in Markdown (as this presentation!). Vignettes are more detailed than function documentation. A vignette can e.g. describe how to combine different functions in the package to solve a complex problem. Example:
https://cran.r-project.org/web/packages/pdSpecEst/vignettes/depth_ranktests.html

### Setup
* Install rmarkdown and knitr packages with `install.packages(c("rmarkdown", "knitr"))`
* Install **pandoc** -> http://pandoc.org/installing.html
* Run `devtools::use_vignette("my-vignette")` creating necessary files/folders

### Workflow
* Modify the vignette
* **Knit** vignette with `Ctrl/Cmd + Shift + K` or clicking the `Knit` button

### Markdown and Knitr
**Markdown** is a simple text formatting language, not as flexible as LaTeX, but easy to write and read. **Knitr** allows to intermingle code and text by running R code and translating it into formatted Markdown. See http://r-pkgs.had.co.nz/vignettes.html for a good intro to Markdown/Knitr with RStudio.

Compiled code*
=========================================================
class: small-code

Speed up your code by including `C` or `C++` code in your package with `Rcpp` (and `RcppArmadillo` or `RcppEigen`). For more details, see e.g. http://adv-r.had.co.nz/Rcpp.html or http://r-pkgs.had.co.nz/src.html.

### To illustrate

```r
## write C++ function
Rcpp::cppFunction(depends = "RcppArmadillo", 'arma::cx_mat mExp_C(arma::cx_mat A) {
  arma::cx_mat A_exp = arma::expmat(A);
  return A_exp;
}')

## write R function
mExp_R <- function(A){
  e <- eigen(A)
  e$vectors %*% diag(exp(e$values)) %*% solve(e$vectors)
}

## Computation times
A <- matrix(complex(real = rnorm(4), imaginary = rnorm(4)), nrow = 2)
microbenchmark::microbenchmark(mExp_R(A), mExp_C(A))
```

```
# Unit: microseconds
#       expr     min       lq      mean   median       uq      max neval
#  mExp_R(A) 229.675 236.1565 328.36833 242.0670 257.8125 4586.144   100
#  mExp_C(A)  15.894  17.7080  32.68072  23.6085  25.4180  935.461   100
```

Git and GitHub
=========================================================

### Motivation
**Git** is a version control system that tracks changes in your code and allows to undo mistakes. **GitHub** is a website where you can share code and work together with others via e.g. pull requests or track issues.

* Installing an R-package from GitHub is (very) easy:


```r
devtools::install_github("JorisChau/moviesdemo")
```

### Set up Git/GitHub with RStudio
* Install Git
* In a Git shell, configure username and email, (check with `git config --global --list`)

```r
git config --global user.name "YOUR FULL NAME"
git config --global user.email "YOUR EMAIL ADDRESS"
```
* Create a GitHub account on https://github.com (use the same email as above)
* If needed, generate a SSH key, see http://r-pkgs.had.co.nz/git.html for details
* In RStudio: `Tools > Project Options > Git/SVN` change Version Control System to `Git`
* In a Git shell, run `git init` and restart RStudio ...

Git and GitHub
=========================================================

* New **Git** pane tracks changes in the code:

<img src="pictures/Fig4.png" title="plot of chunk unnamed-chunk-17" alt="plot of chunk unnamed-chunk-17" width="100%" style="display: block; margin: auto;" />

Git and GitHub
=========================================================

### To create a new commit (often)

* Save changes and open `commit` window in Git pane
* Stage (select) files for inclusion in commit
* Write a (meaningful) commit message and commit

**Tip**: Add files you do not want to include to `.gitignore` (e.g. temporary folders or large files).

### Undo mistakes
* Roll back changes to previous commit by clicking on `More > Revert` (cannot undo!)
* You can also undo changes to part of a file or individual lines or changes that occured before the last commit, see e.g. http://r-pkgs.had.co.nz/git.html for more details

<img src="pictures/Fig5.png" title="plot of chunk unnamed-chunk-18" alt="plot of chunk unnamed-chunk-18" width="100%" style="display: block; margin: auto;" />

Git and GitHub
=========================================================

### Setup remote repo GitHub
* Create a new repo on Github: https://github.com/new with the same name as the package and package title as repo description
* Follow instructions from GitHub, similar to (Git shell):

```r
git remote add origin https://github.com/JorisChau/moviesdemo.git
git push -u origin master
```
(First line assigns remote repo to `origin`. Second line **pushes** (publishes) local repo `master` to remote repo `origin`).

### Synchronizing with GitHub
* Commit locally until ready to push
* Press **Push** in Git pane
* Go to GitHub page and verify modifications

Go to, for instance, http://r-pkgs.had.co.nz/git.html to learn how to work together with others using Git + GitHub (e.g. *branches*, *pull requests*, *tracking issues*, etc.).

Checking package
=========================================================

### Workflow
* Run `devtools::check()` or press `Ctrl/Cmd + Shift + E`
* Fix errors/warnings/notes
* Repeat until there are no more errors/warnings/notes

### Check messages
* **ERROR**: severe problem that needs to be fixed in any case
* **WARNING**: problems that must be fixed if you want to submit to CRAN (or e.g. Bioconductor)
* **NOTE**: mild problems, if you submit to CRAN try to eleminate all notes, if not explain why the note is not a problem in CRAN submission comments.

### Example output `devtools::check()`
<img src="pictures/Fig6.png" title="plot of chunk unnamed-chunk-20" alt="plot of chunk unnamed-chunk-20" width="60%" style="display: block; margin: auto;" />

Checking package and Release
=========================================================

To release package on CRAN, the package need to build (without errors/warnings) on all major platforms. If you do not have access to different operating systems yourself:

* Check on Windows with win-builder https://win-builder.r-project.org/
* Check on Linux/OS X with Travis

### Setup Travis
* Run `devtools::use_travis()` to set up basic `travis.yaml` configuration

```r
## Example travis.yaml config file
language: R
warnings_are_errors: false
sudo: false
cache: packages
os:
  - linux
  - osx
notifications:
  email: false
```
* Go to https://travis-ci.org/ and enable Travis for repo you want to test
* Push to GitHub and check build results on Travis website

Checking package and Release
=========================================================

### Example output Travis (linux, osx)

<img src="pictures/Fig8.png" title="plot of chunk unnamed-chunk-22" alt="plot of chunk unnamed-chunk-22" width="100%" style="display: block; margin: auto;" />

Checking package and Release
=========================================================

### CRAN Release
* Verify that the package passes `devtools::check()` on the major platforms (windows, linux, osx) and you adhere to CRAN policies
* Change the version number in `DESCRIPTION` and update `README.md`, `NEWS.md`, `cran-comments.md`
* Be aware of backward compatibility, see http://r-pkgs.had.co.nz/release.html
* Submit to CRAN with `devtools::release()`

After acceptance CRAN builds binary packages for each platform (may uncover further errors).
<img src="pictures/Fig7.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" width="50%" style="display: block; margin: auto;" />

Shiny applications
=========================================================
class: small-code

### Motivation
In addition to vignettes, it may be useful (not always!) to interactively demonstrate the package functionalities with an R shiny application, e.g. http://jchau.shinyapps.io/moviesdemo

### Host Shiny app online

* Publish Shiny app to public server (e.g. http://shinyapps.io) via the `Deploy App` button
* Deployed Shiny app can fetch R packages from CRAN or GitHub
* Include link to in `README.md` or `DESCRIPTION` file

### Include Shiny app in package

* add `Imports: shiny` to `DESCRIPTION` file
* Place Shiny app in `inst/shiny-examples/myapp/` and add `runapp.R` to `R/`
* Run app from within R via `moviesdemo::runMovieApp()`. Excerpt from `runapp.R`:


```r
runMovieApp <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "moviesdemo")
  if (appDir == ""){
    stop("Could not find example directory. Try re-installing `moviesdemo`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
```



