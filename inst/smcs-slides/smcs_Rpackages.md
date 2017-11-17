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

Demo package
========================================================

### `moviesdemo` R-package

* We created a demonstration R-package `moviesdemo` accompanying the slides
* This package contains the necessary folders and files for a basic R-package
* You can compare and copy files from `moviesdemo` to your own R-package (created from scratch)

### Package details

* The package includes a dataset containing metadata (e.g. title, popularity, plot, etc.) on 4800 movies from The Movie Database (TMDb)
* The goal of the package is to advise similar movies to watch based on a movie selected by the user
* The package includes a Shiny application to give the functions a user-friendly interface

### Clone `moviesdemo` to your PC

Install **Git** To clone or download (not install!) the package to your local PC:

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

Work with existing R packages
========================================================

Published packages (13/11/17): 11.809 on CRAN and 1.476 on Bioconductor

### Install and load a R package

```r
# ------- INSTALL ---------------
install.packages("x")
# or
source("https://bioconductor.org/biocLite.R")
biocLite("x")
# or
install_github("x")

# ------- LOAD and ATTACH -------
library("x")
```

&nbsp;

### Examples of R packages

* https://github.com/ManonMartin/MBXUCL
* https://cran.r-project.org/web/packages/pdSpecEst/


 5 ≠ package states
========================================================
* **source**: what we are currently working on during package development
* **bundled**: compressed single file (`.tar.gz.`); intermediary state  (Windows/Mac) or for Linux distribution
* **binary**: compressed single file used to distribute your package (very different internal structure); platform specific: `.zip` (Windows), `.tgz` (Mac)
* **installed**: decompressed package into a package library (i.e. directory containing installed packages)
* **in-memory**: loaded package, required to be used

<img src="pictures/PackageStates.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="40%" style="display: block; margin: auto;" />
<div style="text-align: right; font-size:0.5em;" > [source: https://github.com/rstudio/cheatsheets/raw/master/package-development.pdf ] </div>


Why you should write a R package
========================================================
## PROS

### Automation is key for time-saving
* Avoid coding errors
* Functions, data etc. documentation
* Conventions and tools standardisation
* Available tests and checks

### Portable code
* Easier to share code within your team and/or carry out a group work
* Open your code to the R community (extra testing for bugs, meet new needs, etc.)
* Publish and value your coding work (along with your articles)
* For Shiny app deployment hosted online (GitHub)

&nbsp;


## CONS
* More upstream work
* must pass checks and meet the standards


The `devtools` R package
========================================================
### Motivations
*= Tools to make Developing R Packages Easier*
* Simplifies and automates common development tasks
* Encapsulated and developed in parallel with RStudio
* Incorporates the best practices of package development

&nbsp;

### Few useful `devtools` functions
  * `create("path-to/package-name")`: Creates a new package with the directory structures
  * `load_all()`: Loads a package in memory
  * `document()`: Uses Roxygen to document a package
  * `check()`: Checks and builds and  a source package
  * `build()`: Builds a source package
  * `test()`: Executes the `test_that` tests in a package



more info: https://cran.r-project.org/web/packages/devtools/


The RStudio interface and start of a package
========================================================

### Useful RStudio facilities
* Only within a project!
* **Build** (tools for building and testing packages) and **Git** (Git and GitHub version control system) **tab panes**


### Initiate a package
* `File > New Project > New Directory > R package`  (or  `devtools::create("path-to/package-name")`)

<img src="pictures/RPackageCreation.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="30%" style="display: block; margin: auto;" />


* Set the package name and the project directory
* Select source files (= R scripts) (optionnal)
* Create a git repository (optionnal)

**Note**: The choice of the name is important for your package visibility!! Name it with letters, numbers and periods; it must start with a letter and cannot end with a period.

Package structure
========================================================

&nbsp;
&nbsp;

<img src="pictures/PackageStructure.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="65%" style="display: block; margin: auto;" />
<div style="text-align: right">
(not exhausitive) </div>

<div style="text-align: right; font-size:0.5em;" > [source: https://github.com/rstudio/cheatsheets/raw/master/package-development.pdf ] </div>



DESCRIPTION (1)
========================================================

## Motivation

Mandatory DCF file that storages the package metadata. Mainly specifies dependencies, who can use it (license) and whom to contact in case of problems.


## Structure

<div class="sourceCode"><pre class="sourceCode yaml"><code class="sourceCode yaml"><span class="fu"><font color="#8A0868">fieldName: </font></span>value</code></pre></div>

<code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Title </font></span></code> is a one line description of the package

<code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Description </font></span></code> Multiple sentences short description of the package.

<code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Authors@R </font></span></code> Package *Authors* (`"aut"`), Creator and package *Maintainer* (`"cre"`), Contributors (`"ctb"`), etc. [Comprehensive list](http://www.loc.gov/marc/relators/relaterm.html)

<code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Version </font></span></code>
* Released version: `<major>.<minor>.<patch>`
* In-development package: 4th component, starts at 0.0.0.9000

<code class="sourceCode yaml"><span class="fu"><font color="#8A0868">License </font></span></code>
Important for the package release. Explain who and how to use the package (e.g. GPL-3)
A `LICENSE` file can be added for more information.



<code class="sourceCode yaml"><span class="fu"><font color="#8A0868">LazyData </font></span></code>Set to `TRUE` by default






DESCRIPTION (2)
========================================================

### Excerpt from moviesdemo/DESCRIPION

<div class="sourceCode"><pre class="sourceCode yaml"><code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Package: </font></span>moviesdemo
<span class="fu"><font color="#8A0868">Type: </font></span>What the Package Does (Title Case)
<span class="fu"><font color="#8A0868">Version: </font></span>0.0.0.9000
<span class="fu"><font color="#8A0868">Authors@R: </font></span>c(
    person("Joris", "Chau", email = "j.chau@uclouvain.be", role = c("aut", "cre")),
    person("Manon", "Martin", email = "manon.martin@uclouvain.be", role = "aut"))
<span class="fu"><font color="#8A0868">Description: </font></span>More about what it does (maybe more than one line)
    Use four spaces when indenting paragraphs within the Description.
<span class="fu"><font color="#8A0868">License: </font></span>CC0
<span class="fu"><font color="#8A0868">URL: </font></span>https://github.com/JorisChau/moviesdemo
<span class="fu"><font color="#8A0868">Encoding: </font></span>UTF-8
<span class="fu"><font color="#8A0868">Depends: </font></span>R (>= 3.3.1)
<span class="fu"><font color="#8A0868">LazyData: </font></span>true
<span class="fu"><font color="#8A0868">Imports: </font></span>shiny
<span class="fu"><font color="#8A0868">RoxygenNote: </font></span>6.0.1
<span class="fu"><font color="#8A0868">Suggests: </font></span>
    knitr,
    rmarkdown,
    testthat
<span class="fu"><font color="#8A0868">VignetteBuilder: </font></span>knitr
</code></pre></div>



Dependencies in DESCRIPTION
========================================================
Comma separated list of needed package names.

* <code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Imports: </font></span></code>
Packages listed must be present and are installed if not.

**Tip**: ! `Imports` will only ensure that it is *installed* and will not *attach* it <br />
=> Best practice:  refer explicitly to external functions with `package::function()`.


* <code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Suggests: </font></span></code>
The packages are not required for installation but can be used (e.g. for datasets, to run tests or build vignettes, specific function needing the package).

Test if a suggested package is available for a specific function `FUN`:


```r
FUN <- function(x) {
  if (!requireNamespace("suggestedPackage", quietly = TRUE)) {
    stop("suggestedPackage installation is necessary for function FUN")
  }
}
```





* <code class="sourceCode yaml"><span class="fu"><font color="#8A0868">Depends: </font></span></code> Used to require a specific version of R i.e. require a version greater than or equal to the currently used version.


**Notes:**
* Alternative setting of dependencies: namespace imports
* Versioning to specify a minimum package version: `Suggests: knitr(>=1.17)`



More package documentation
========================================================
* Create a `README.md`

Suggested structure (from Hadley Wickham):

1. Describe the high-level purpose of the package
2. An example where the package is applied
3. Installation instructions
4. Overview of the main components of the package (a Vignette is more exhaustive!)

&nbsp;

* Package documentation


```r
help("moviesdemo")
```




R scripts Good practices (1)
========================================================
### Functions names
Should be meaningful and end with `.R`

### Code style
* `formatR::tidy_dir()`: automatically reformats R code
* `lintr::lint_package()`: warns about problems
* Check conventions for object names, spacing, {}, commenting, indentation, etc. (cf. http://adv-r.had.co.nz/Style.html)

### Top-level code rules in the scripts
Never use: `library()` or `require()` packages will not be loaded and modifies the search path; `source()` modifies the current environment

Use carefuly (reset after use): the global `options()`,  the graphical parameter `par()`, all functions modifying default directories (e.g. `.libPaths()`, `setwd()`)

**Tip** for the R functions development workflow: use `devtools::load_all()` to avoid a re-installation
<img src="pictures/load_all.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="55%" style="display: block; margin: auto;" />


R scripts Good practices (2)
========================================================
### Input arguments check


```r
FUN <- function(a, type = c("mean", "median")) {
  switch(type,
         mean = mean(a),
         median = median(a))
}
```


```r
FUN(a = c(1, 4, 6, "R", 5, 2, 1) , type="mean")
```

```
# Warning in mean.default(a): argument is not numeric or logical: returning
# NA
```

```
# [1] NA
```


```r
FUN(a = c(1, 4, 6, 5, 5, 2, 1), type="meen")
```


R scripts (3)
========================================================
## Good practices
### Input arguments check


```r
FUN <- function(a, type = c("mean", "median")) {
   if (!is.numeric(a)) {
    warning(deparse(substitute(a)), " is not numeric")
   }
  type <- match.arg(type)
  switch(type,
         mean = mean(a),
         median = median(a))
}
```


```r
FUN(a = c(1, 4, 6, "R", 5, 2, 1), type="meen")
```

```
# Warning in FUN(a = c(1, 4, 6, "R", 5, 2, 1), type = "meen"): c(1, 4, 6,
# "R", 5, 2, 1) is not numeric
```

```
# Error in match.arg(type): 'arg' should be one of "mean", "median"
```


```r
FUN(a = c(1, 4, 6, 5, 5, 2, 1), type="mean")
```

```
# [1] 3.428571
```


Help files
========================================================
In the `man/` directory

### Motivations
R documentation



* Located in the `man` directory
* Slightly different between packages, functions or datasets descriptions
* RStudio documentation tools include: **Preview** command, spell-checking, and Roxygen aware editing

### Help file format (`.Rd`) \~ LaTeX


### Excerpt from moviesdemo/man/advise.good.movie.Rd

```r
\name{advise.good.movie}
\alias{advise.good.movie}
\title{Advise movies based on another movie}
\usage{
advise.good.movie(similar_to, how_many, ...)
}
\arguments{
\item{similar_to}{character, movie title from the database.}
\item{how_many}{integer, how many movies to advise.}
\item{...}{additional arguments.}
}
\description{
Documentation...
}
```


Write help files with the roxygen2 package (1)
========================================================

### Motivations
sta



### Workflow
* Write Roxygenize comments always starting with `'#` either in a new R script (package or data) or at the top of the R script already containing the function
*
* Generate the documentation:
`devtools::document(".")` or `Ctrl+Shift+D`


### Useful fields

@docType



Write help files with the roxygen2 package (2)
========================================================

### Excerpt from moviesdemo/R/advise.R

```r
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

# ---- advise.good.movie function body ----

  }
```

Help files
========================================================

### Create pdf reference manual

In order to create a pdf reference manual from the documentation (`.Rd`) files, you can run in R:


```r
system("R CMD Rd2pdf /path/to/package_root")
```

**Note**: if you submit your package to CRAN, the reference manual is created automatically by CRAN, (e.g. https://cran.r-project.org/web/packages/pdSpecEst/pdSpecEst.pdf)


NAMESPACE*
========================================================

### Motivating example

```r
nrow
```

```
# function (x) 
# dim(x)[1L]
# <bytecode: 0x7ff17cb77790>
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

<img src="pictures/Fig3.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" width="55%" style="display: block; margin: auto;" />


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























```
Error in sourceCpp(code = code, env = env, rebuild = rebuild, cacheDir = cacheDir,  : 
  Error 1 occurred building shared library.
```
