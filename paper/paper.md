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

Although many animal populations are managed based on their abundance [@williams_analysis_2002], reliable abundance estimates can be impractical to obtain for mobile herding populations with large ranges such as boreal caribou (*Rangifer tarandus caribou*).
Consequently, such populations are commonly managed based on their population growth rate ($\lambda$), which can be estimated from the population recruitment (R) and adult female survival (S) rates [@hatter_moose_1991]. 

The `bbou` suite is a set of R packages to facilitate simulation and analysis of Boreal Caribou survival and recruitment data to estimate population growth ($\lambda$).
It consists of:  
- [`bboudata`](https://poissonconsulting.github.io/bboudata/), a collection of real (anonymized) and simulated boreal caribou survival and recruitment example data.  
- [`bboutools`](https://poissonconsulting.github.io/bboutools/), a set of tools for estimating boreal caribou survival, recruitment and population growth in a Bayesian or Maximum Likelihood [@millar_maximum_2011] framework, implemented under the hood using the `Nimble` R package [@de_valpine_programming_2017].   
- [`bboushiny`](https://poissonconsulting.github.io/bboushiny/), a Graphical User Interface (GUI) to bboutools functionality (figure 1).  
- [`bbouretro`](https://poissonconsulting.github.io/bbouretro/), a set of tools for estimating boreal caribou survival, recruitment and population growth using traditional frequentist methods.  
- [`bbousims`](https://poissonconsulting.github.io/bbousims/), a set of tools to simulate boreal caribou survival and recruitment data.

Each R package in the suite has a website with function documentation and a 'Get Started' guide.
In addition, there are several vignettes, including on `bboutools` [analytical methods](https://poissonconsulting.github.io/bboutools/articles/methods.html) and [prior selection](https://poissonconsulting.github.io/bboutools/articles/priors.html); `bbouretro` [analytical methods](https://poissonconsulting.github.io/bbouretro/articles/retro-methods.html); [use of `bbousims` with `bboutools`](https://poissonconsulting.github.io/bbousims/articles/bboutools.html); a [detailed empirical comparison of Bayesian and classical methods methods](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html) and [a comparison using simulated data](https://poissonconsulting.github.io/bbousuite/articles/simulations.html). 

TODO figure shiny app

# Statement of need

Boreal caribou are found in most provinces and territories in Canada and have been listed as threatened since 2003 [@ECCC_2023].
Each jurisdiction has their own monitoring program responsible for boreal caribou.
Numerous methods have been used to estimate population growth, which can make cross-jurisdictional conversations on the health of the species complex. 

In general, the suite of R packages in `bbousuite` aims to address this.
`bboutools` provides a standardized methodology with simple, general models and sensible defaults for estimating survival, recruitment and population growth that can be compared across jurisdictions.
In addition, `bboushiny` provides access to basic `bboutools` functionality in a GUI; `bbouretro` facilitates comparison with historical methods; and `bbousims` provides tools to simulate data and thus facilitates comparison of various methods' ability to recover known parameter values. 

There is an existing web-based application [@eacker_webbased_2019] for estimating population growth rate. 
However,  users reported that it was difficult to use, especially if not familiar with Bayesian statistics, and had too many options to be a standarized method. 
There is also an existing R package, `caribouMetrics`, and associated web-based application, `BayesianCaribouDemographicProjection`. 
While some functionality is similar, the motivation for which focus on projection and integration with habitat models... (TODO add more here).

# Overview and comparison of methods

The Bayesian methods in `bboutools` are intended to replace the classical methods in `bbouretro`. 
In particular, the random effects model is recommended by default where there are $\geq$ 5 years of data [@kery_bayesian_2011]. 
Despite some key differences in methods, `bboutools` and `bbouretro` use the same underlying formulas to estimate survival, recruitment and population growth. 

Survival is estimated from the monthly fate of collared adult females using the staggered entry Kaplan-Meier method [@pollock_survival_1989].  

$$ \hat{S}_{ij} = 1 - \frac{d_{i}}{r_{i}} $$

where $\hat{S}_{i}$ is the survival probability for the $i^{th}$ period, $d_{ij}$ is the number of mortalities during the period and $r_{i}$ is the number of collared individuals at the start of the period.

Annual survival $\hat{S}(j)$ in the $j^{th}$ year is estimated as 
$$\hat{S}(j) = \prod_{i=1}(\hat{S}_{i,j})$$

There is an option in both `bboutools` and `bbouretro` to include uncertain mortaliites in the total mortalities summed prior to model fitting. 

Recruitment is estimated from annual composition surveys of boreal caribou groups with methods following DeCesare et al. [-@decesare_estimating_2012] 

$$R_{\Delta} = \frac{X \cdot sex\_ratio}{1 + X \cdot sex\_ratio}$$

where $X \cdot sex\_ratio$ is the female calves per adult female and $R_{\Delta}$ accounts for recruitment of calves into the yearling/adult age class at the end of the caribou year.

Population growth ($\lambda$) is estimated using the basic Hatter-Bergerud method [@hatter_moose_1991].

$$\lambda = \frac{S}{1-R_\Delta}$$

Both `bboutools` and `bbouretro` allow the user to adjust the start month of the biological year.
Data are aggregated by biological year prior to model fitting.

A full comparison of Bayesian methods in `bboutools` and traditional frequentist methods of `bbouretro` is out of scope.
However, a key difference is that `bboutools` methods are parametric and `bbouretro` methods are non-parametric. 
Parametric methods assume that the data are drawn from a pre-defined statistical distribution, i.e., the binomial distribution in the case of survival and recruitment models. 
Inference is based on the underlying statistical model, which allows for inference on statistical significance of model parameters. 
For non-parametric approaches in `bbouretro`, which do not assume an underlying statistical model, estimates are based on simple ratios, with variances estimated using approximation formulas (survival) or bootstrap resampling methods. 

Key advantages of the parametric approach are that:  
- year can be modeled as a random effect, where parameter values are assumed to be drawn from a common underlying distribution and information is shared among years.  
- models can include estimation of an underlying trend.  
- uncertainty around survival estimates can be estimated in cases where there are 0 mortalities in a year; this is not possible using traditional methods.  
- for models analyzed in a Bayesian framework, prior knowledge can be incorporated, which can be especially useful when data are sparse.  

The `bboutools` approach uses heirarchical Generalized Linear Models to estimate survival and recruitment. 

A survival model including a year random effect and trend takes the form
$$d_{i,j} ~ Binomial(1 - \hat{S}_{i,j}, r_{i,j})$$
$$logit(\hat{S}_{i,j}) = \beta_{0} + \alpha_{i} + \delta_{j} + \beta_{1} * Year_{j}$$  
$$\alpha_i ~ Normal(0, \sigma_{\alpha})$$  
$$\delta_j ~ Normal(0, \sigma_{\delta})$$ 

where $d_{i,j}$ is the number of mortalities in the $i^{th}$ month and $j^{th}$ year, $r_{i,j}$ is the number of collared individuals at the start of the month, $\hat{S}_{i,j}$ is the survival probability, $\alpha_i$ is a monthly random effect, $\delta_i$ is an annual random effect and `\beta_{1}` represents the trend. 

A recruitment model including random and trend takes the form
$$Calves_{j} ~ Binomial(\delta[i], AdultFemales[i])$$
$$logit(\delta_{j}) = \beta_{0} + \alpha_{j} + \beta_{1} * Year[i]$$
$$\alpha_{j} ~ Normal(0, \sigma_{\alpha})$$
$$FemaleYearlings_{j} ~ Binomial(sex_ratio, Yearlings_{j})$$
$$Cows_{j} ~ Binomial(adult_female_proportion, CowsBulls_{j})$$
$$AdultFemalesOther_{j} ~ Binomial(adulte_female_proportion, AdultsUnknown_{j})$$
$$AdultFemales_{j} = FemaleYearlings_{j} + Cows_{j} + AdultFemalesOther_{j}$$

where $\delta_{j}$ is the calves per adult female in the $j^{th}$ year, $\alpha_{j}$ is an annual random effect and $\beta_{1}$ represents the trend. 

Groups are aggregated by year prior to model fitting to prevent the number of calves exceeding the number of cows.
The sex ratio is fixed and can be adjusted by the user, with default of 0.5.
The adult female proportion can be estimated from counts of cows and bulls or fixed, with a default of 0.65, which accounts for higher mortality of males (Smith 2004).
The model includes demographic stochasticity.

The models are identical for ML and Bayesian frameworks, although methods for parameter estimation differ and prior information can be incorporated in the Bayesian framework. 
By default, `bboutools` uses uninformative priors and these can be adjusted by the user. 

An [empirical comparison](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html) of `bbouretro` and `bboutools` methods (i.e., on real data) showed that `bbouretro` methods yield similar results to Bayesian fixed-effects models with vague priors.
As well, ML and Bayesian models yield similar results when priors are vague.
Random effects models tend to differ from traditional/fixed effect models, with annual estimates pulled in toward the grand mean (figure...). 
We would

Simulating data (i.e., with `bbousims`) allows for comparison of various methods' ability to recover known parameter values. 
[We compared](https://poissonconsulting.github.io/bbousuite/articles/simulations.html) `bbouretro` methods with `bboutools` Bayesian models with fixed or random year effects across 100 simulations, 20 years and 5 sample size scenarios (i.e., collared adult females, groups observed in hypothetical composition surveys). 

TODO figure of comparison 

In general, the Bayesian random effects model performed best. 
This model had the lowest bias, especially at lower sample sizes (figure ). 

As mentioned above, random effect models exhibit 'shrinkage', i.e., the sharing of information across years, which causes outlier estimates to be brought towards the grand mean [@kery_bayesian_2011]. 
This is particularly true when underlying data are sparse.
With higher sample size in each group (year), the difference between random and fixed effects models is diminished. 
The simulation analysis demonstrates that the tendency to be skeptical of extreme values at low sample sizes is desirable, as these values are likely to result from the sampling process rather than represent the true values. 

# Acknowledgements

We acknowledge contributions from Alan Constant.
Development of `bbousuite` was funded by the Province of Alberta and Environment and Climate Change Canada.

# References




To load all the packages you can use `library(bbousuite)` or each package can be loaded individually such as `library(bboudata)`.

```r
set.seed(101)
library(bbousuite)
print(bboudata::bbousurv_c, n = 5)
```

```r
# A tibble: 122 × 6
  PopulationName  Year Month StartTotal MortalitiesCertain MortalitiesUncertain
  <chr>          <int> <int>      <int>              <int>                <int>
1 C               2003     3          0                  0                    0
2 C               2003     4         10                  2                    0
3 C               2003     5          5                  0                    0
4 C               2003     6          5                  1                    0
5 C               2003     7          4                  0                    0
# ℹ 117 more rows
# ℹ Use `print(n = ...)` to see more rows
```

``` r
survival_est <-
  bbouretro::bbr_survival(
    bboudata::bbousurv_c,
    mort_type = "total",
    variance = "greenwood"
  )
  
recruitment_est <-
  bbouretro::bbr_recruitment(
    bboudata::bbourecruit_c,
    p_females = 0.65,
    sex_ratio = 0.5,
    variance = "bootstrap"
  )

growth_est <- bbouretro::bbr_growth(survival_est, recruitment_est)
bbouretro::bbr_growth_summarize(growth_est)
```

``` r
# A tibble: 9 × 13
  PopulationName CaribouYear     S     R estimate     se  lower  upper prop_lgt1
  <chr>                <int> <dbl> <dbl>    <dbl>  <dbl>  <dbl>  <dbl>     <dbl>
1 C                     2004 0.867 0.096    0.959  0.115  0.636  1.08      0.323
2 C                     2005 0.832 0.08     0.904  0.105  0.633  1.03      0.093
3 C                     2006 1     0.068    1.07  NA     NA     NA        NA    
4 C                     2007 0.458 0.059    0.487  0.128  0.262  0.766     0    
5 C                     2008 0.941 0.083    1.03   0.1    0.739  1.16      0.615
6 C                     2009 1     0.14     1.16  NA     NA     NA        NA    
7 C                     2010 0.926 0.158    1.1    0.085  0.877  1.23      0.854
8 C                     2011 0.96  0.112    1.08   0.075  0.872  1.16      0.861
9 C                     2012 0.924 0.133    1.07   0.072  0.875  1.15      0.808
# ℹ 4 more variables: mean_sim_survival <dbl>, mean_sim_recruitment <dbl>,
#   mean_sim_growth <dbl>, median_sim_growth <dbl>
```

``` r
surv_fit <- bboutools::bb_fit_survival(bboudata::bbousurv_c, quiet = TRUE)
recruit_fit <- bboutools::bb_fit_recruitment(bboudata::bbourecruit_c, quiet = TRUE)

bboutools::bb_predict_growth(surv_fit, recruit_fit)
```

``` r
# A tibble: 9 × 4
  CaribouYear estimate lower upper
        <int>    <dbl> <dbl> <dbl>
1        2004    1.06  0.879  1.12
2        2005    1.03  0.823  1.11
3        2006    1.09  1      1.13
4        2007    0.858 0.476  1.08
5        2008    1.07  0.942  1.13
6        2009    1.12  1.03   1.18
7        2010    1.1   0.957  1.18
8        2011    1.1   0.99   1.15
9        2012    1.09  0.963  1.16
```

``` r
survival <- bbousims::bbs_survival_caribou(
  survival_adult_female = 0.85,
  annual_sd_adult_female = 0.2,
  trend_adult_female = -0.1,
  month_sd_adult_female = 0.1,
  survival_calf_female = 0.5,
  yearling_effect = 0.05,
  nyear = 5
)

fecundity <- bbousims::bbs_fecundity_caribou(
  calves_per_adult_female = 0.7,
  annual_sd = 0.1,
  nyear = 5
)

population <- bbousims::bbs_population_caribou(survival,
  fecundity = fecundity,
  adult_females = 500,
  proportion_adult_female = 0.65
)

bbousims::bbs_plot_population(population)
```

![](figures/bbousims-population.png)

``` r
bboushiny::run_bbou_app()
```

![](figures/bboushiny-survival.png)

Additional examples and usage of each package can be on their websites. 

Models analyzed in a Bayesian framework use biologically reasonable, weakly informative priors by default.
Priors can be modified by the user. 
By default, the Bayesian method saves 1,000 MCMC samples from each of three chains (after discarding the first halves). 
The number of samples saved can be adjusted. 
The user can increment the thinning rate as required to achieve convergence, which is assessed using ess (Effective Sample Size) and rhat (TODO ref).
# Example of use