
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbousuite

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/poissonconsulting/bbousuite/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/bbousuite/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/bbousuite/branch/main/graph/badge.svg)](https://app.codecov.io/gh/poissonconsulting/bbousuite?branch=main)
<!-- badges: end -->

The goal of `bbousuite` is to make it easy to install and load the
(`bbou`) suite of R packages for Boreal cariBOU.

The packages are designed to analysis (`bbouretro` and `bboutools`) and
simulate (`bbousims`) Boreal Caribou survival and recruitment data
(`bboudata`) to estimate population growth rates. A shiny app is also
available (`bboushiny`).

## Installation

You can install the latest version of `bbousuite` from
[GitHub](https://github.com/poissonconsulting/bbousuite) with:

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/bbousuite")
```

## Load

To load `bbousite`

``` r
library(bbousuite)
```

### Packages

The packages installed and loaded by `bbousuite` suite are:

- [bboudata](https://github.com/poissonconsulting/bboudata)
- [bbouretro](https://github.com/poissonconsulting/bbouretro)
- [bboutools](https://github.com/poissonconsulting/bboutools)
- [bbousims](https://github.com/poissonconsulting/bbousims)
- [bboushiny](https://github.com/poissonconsulting/bboushiny)
