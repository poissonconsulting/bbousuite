
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

The `bbou`suite is a set of R packages to facilitate simulation and
analysis of boreal caribou survival and recruitment data to estimate
population growth.

It consists of:

- [`bboudata`](https://poissonconsulting.github.io/bboudata/), a
  collection of simulated and anonymized empirical survival and
  recruitment datasets.  
- [`bboutools`](https://poissonconsulting.github.io/bboutools/), a set
  of functions to estimate population growth in a Bayesian or Maximum
  Likelihood (ML) framework, implemented under the hood using the
  [Nimble](https://r-nimble.org) R package.  
- [`bboushiny`](https://poissonconsulting.github.io/bboushiny/), a
  Graphical User Interface (GUI) to `bboutools`.  
- [`bbouretro`](https://poissonconsulting.github.io/bbouretro/), a set
  of functions to estimate population growth using traditional
  frequentist methods.  
- [`bbousims`](https://poissonconsulting.github.io/bbousims/), a set of
  functions to simulate survival and recruitment data from hypothetical
  radio-collaring and composition surveys.

Each R package has a website with function documentation and a ‘Get
Started’ guide.  
If you are completely new to the `bbou` suite, we recommend taking a
look at the [bboutools ‘Get Started’
guide](https://poissonconsulting.github.io/bboutools/articles/bboutools.html)
as this demonstrates core functionality and methods.

There are also several vignettes, including `bboutools` [analytical
methods](https://poissonconsulting.github.io/bboutools/articles/methods.html)
and [prior
selection](https://poissonconsulting.github.io/bboutools/articles/priors.html),
`bbouretro` [analytical
methods](https://poissonconsulting.github.io/bbouretro/articles/retro-methods.html),
using [`bbousims` with
`bboutools`](https://poissonconsulting.github.io/bbousims/articles/bboutools.html),
and comparison of Bayesian and traditional method estimates with
[empirical](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html)
and
[simulated](https://poissonconsulting.github.io/bbousuite/articles/simulations.html)
data.

## Installation

You can install the latest version of `bbousuite` from
[GitHub](https://github.com/poissonconsulting/bbousuite) with:

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/bbousuite")
```

## Load

To load `bbousuite`

``` r
library(bbousuite)
#> Attaching: bboudata bbouretro bboushiny bbousims bboutools bbousuite
#> Warning: package 'bbousims' was built under R version 4.4.3
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

Please note that the bbou project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Licensing

Copyright 2022-2023 Environment and Climate Change Canada  
Copyright 2023-2024 Province of Alberta  

The documentation is released under the [CC BY 4.0
License](https://creativecommons.org/licenses/by/4.0/)

The code is released under the [Apache License
2.0](https://www.apache.org/licenses/LICENSE-2.0)
