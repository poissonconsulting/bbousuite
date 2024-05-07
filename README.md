
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
(`bbou`) suite of R packages for **B**oreal cari**BOU**.

The packages are designed to analysis (`bbouretro` and `bboutools`) and
simulate (`bbousims`) boreal caribou survival and recruitment data
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
#> Attaching: bboudata bbouretro bboushiny bbousims bboutools bbousuite
```

### Packages

The packages installed and loaded by `bbousuite` suite are:

- [bboudata](https://github.com/poissonconsulting/bboudata)
- [bbouretro](https://github.com/poissonconsulting/bbouretro)
- [bboutools](https://github.com/poissonconsulting/bboutools)
- [bbousims](https://github.com/poissonconsulting/bbousims)
- [bboushiny](https://github.com/poissonconsulting/bboushiny)

## Inspiration

`bbousuite` was inspired by the
[`tidyverse`](https://github.com/tidyverse/tidyverse) package.

## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/poissonconsulting/bbousuite/issues/).

## How to Contribute

If you would like to contribute to the package, please see our
[CONTRIBUTING](https://github.com/poissonconsulting/bbousuite/blob/master/.github/CONTRIBUTING.md)
guidelines.

## Code of Conduct

Please note that the ssdtools project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Licensing

Copyright xx xx  
Copyright 2023-2024 Province of Alberta  

The documentation is released under the [CC BY 4.0
License](https://creativecommons.org/licenses/by/4.0/)

The code is released under the [Apache License
2.0](https://www.apache.org/licenses/LICENSE-2.0)
