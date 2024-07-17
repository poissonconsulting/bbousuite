---
title: 'bbousuite: A set of R packages to facilitate analysis of Boreal Caribou survival and recruitment data'
authors:
- name: Seb Dalgarno
  orcid: 0000-0002-3658-4517
  affiliation: 1
- name: John Boulanger
  orcid: 0000-0001-8222-1445
  affiliation: 2
- name: Ayla Pearson
  orcid: 0000-0001-7388-1222
  corresponding: true
  affiliation: 1
- name: Joe Thorley
  orcid: 0000-0002-7683-4592
  affiliation: 1
- name: Troy Hegel  
  affiliation: 3
- name: Barry Nobert
  affiliation: 3
- name: Dave Hervieux
  affiliation: 3
affiliations:
- index: 1
  name: Poisson Consulting, Canada
- index: 2
  name: Integrated Ecological Research, Canada
- index: 3
  name: Province of Alberta, Canada
date: 6 May 2024
bibliography: paper.bib
tags:
  - caribou
  - Bayesian
  - maximum likelihood
  - survival
  - recruitment
  - population growth
---

# Summary

Although many animal populations are managed based on their abundance [@williams_analysis_2002], in the case of mobile herding populations, such as boreal caribou (*Rangifer tarandus caribou*), which have large ranges, reliable abundance estimates can be impractical to obtain. 
Consequently, such populations are commonly managed based on their population growth rate ($\lambda$) which can be estimated from the population recruitment (R) and adult female survival (S) rates [@hatter_moose_1991]. 

The `bbou` suite of R packages is a set of R packages to facilitate analysis of Boreal Caribou survival and recruitment data to estimate population growth ($\lambda$).
The `bboushiny` R package provides a Graphical User Interface to `bboutools`.

# Statement of need

Boreal Caribou are endangered.
Different jurisdictions different methods.
There is an existing web-based application [@eacker_webbased_2019] but ...

# Technical details

## bboudata

The `bboudata` R package provides sample survival and recruitment data for boreal caribou.

## bbouretro

The `bbouretro` R package contains functions to calculate survival, recruitment and population growth using the classical methods.

## bboutools

The `bboutools` R packages uses the `Nimble` R package [@de_valpine_programming_2017] to fit models using maximum likelihood [@millar_maximum_2011] and Bayesian methods.

## bbousims

The `bbousims` R package allows users to simulate boreal caribou abundance over time from survival, ageing and birth processes. 

## bboushiny

The `bboushiny` R package is a R shiny app for estimating boreal caribou population growth using the Bayesian method from the `bboutools` package. 
`bboushiny` gives non-R users a way to utilize the functions from the `bboutools` package. 

## bbousuite

The `bbousuite` R package facilitates installing and loading the other packages.

# Example of use

The following code ...:

```r
library(bbousuite)
print(bboudata::bbousurv_a, 5)
```

```r
# A tibble: 364 × 6
  PopulationName  Year Month StartTotal MortalitiesCertain MortalitiesUncertain
  <chr>          <int> <int>      <int>              <int>                <int>
1 A               1986     1          0                  0                    0
2 A               1986     2          8                  0                    0
3 A               1986     3          8                  0                    0
4 A               1986     4          8                  0                    0
5 A               1986     5          8                  0                    0
# ℹ 359 more rows
# ℹ Use `print(n = ...)` to see more rows
```

# Acknowledgements

We acknowledge contributions from Alan Constant.
Development of `bbousuite` was funded by the Province of Alberta and Environment and Climate Change Canada.

# References
