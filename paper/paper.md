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
  - boreal caribou
  - Bayesian
  - maximum likelihood
  - survival
  - recruitment
  - population growth
---

# Summary

Although many animal populations are managed based on their abundance [@williams_analysis_2002], reliable abundance estimates can be impractical to obtain for mobile herding populations with large ranges such as boreal caribou (*Rangifer tarandus caribou*).
Consequently, such populations are commonly managed based on their population growth rate ($\lambda$), which can be estimated from the population recruitment and adult female survival rates [@hatter_moose_1991]. 

The `bbou` suite is a set of R packages to facilitate simulation and analysis of Boreal Caribou survival and recruitment data to estimate population growth ($\lambda$).
It consists of:  
- [`bboudata`](https://poissonconsulting.github.io/bboudata/), a collection of real (anonymized) and simulated survival and recruitment data.  
- [`bboutools`](https://poissonconsulting.github.io/bboutools/), functions for estimating survival, recruitment and population growth in a Bayesian or Maximum Likelihood (ML) framework, implemented under the hood using the `Nimble` R package [@de_valpine_programming_2017].  
- [`bboushiny`](https://poissonconsulting.github.io/bboushiny/), a Graphical User Interface (GUI) to `bboutools` functionality (figure 1).    
- [`bbouretro`](https://poissonconsulting.github.io/bbouretro/), functions for estimating survival, recruitment and population growth using traditional frequentist methods.  
- [`bbousims`](https://poissonconsulting.github.io/bbousims/), functions to simulate survival and recruitment data from hypothetical collaring and composition surveys.  

Each R package has a website with function documentation and a 'Get Started' guide.
There are also several vignettes, including on `bboutools` [analytical methods](https://poissonconsulting.github.io/bboutools/articles/methods.html) and [prior selection](https://poissonconsulting.github.io/bboutools/articles/priors.html); `bbouretro` [analytical methods](https://poissonconsulting.github.io/bbouretro/articles/retro-methods.html); using [`bbousims` with `bboutools`](https://poissonconsulting.github.io/bbousims/articles/bboutools.html); comparison of Bayesian and traditional methods using [empirical](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html) amd [simulated](https://poissonconsulting.github.io/bbousuite/articles/simulations.html) data. 

![](figures/bboushiny-survival.png)
*<font size="-1">Figure 1. bboushiny GUI.</font>*

# Statement of need

Boreal caribou are found in most provinces and territories in Canada and have been listed as threatened since 2003 [@ECCC_2023].
Each jurisdiction has their own monitoring program responsible for boreal caribou.
Numerous methods have been used to estimate population growth, which can make cross-jurisdictional conversations on the health of the species complex. 

The suite of R packages in `bbousuite` aims to address this.
`bboutools` provides a standardized methodology with simple, general models and sensible defaults for estimating survival, recruitment and population growth that can be compared across jurisdictions.
In addition, `bboushiny` provides access to basic `bboutools` functionality in a GUI; `bbouretro` facilitates comparison with traditional methods; and `bbousims` provides tools to simulate data and facilitates comparison of various methods' ability to recover known parameter values. 

There is an existing web-based application for estimating boreal cariboupopulation growth rate [@eacker_webbased_2019]. 
However, users reported that it was difficult to use, especially if not familiar with Bayesian statistics, and had too many options to be considered a standarized method. 
There is also an existing R package, `caribouMetrics`, and associated R package to run a GUI, `BayesianCaribouDemographicProjection` with some shared functionality.  
However, the primary goal of these tools is to forecast boreal caribou population under different monitoring and disturbance scenarios [@dyson_2022].

# Overview of methods

Despite key methodological differences (explained below), `bboutools` and `bbouretro` use the same underlying formulas to estimate survival, recruitment and population growth. 
Survival is estimated from the monthly fate of collared adult females using the staggered entry Kaplan-Meier method [@pollock_survival_1989], with an option to include uncertain mortaliites in the total mortalities summed prior to model fitting. 
Recruitment is estimated from annual composition surveys following methods in DeCesare et al. [-@decesare_estimating_2012], where the adjusted recruitment accounts for recruitment of calves into the yearling/adult age class at the end of the caribou year.
Population growth ($\lambda$) is estimated using the Hatter-Bergerud method [@hatter_moose_1991].
More details can be found in [this vignette](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html). 
Both `bboutools` and `bbouretro` allow the user to adjust the start month of the biological year and data are aggregated by biological year prior to model fitting.

A full comparison of the statistical methods used in `bboutools` and `bbouretro` is out of scope here.
However, a key difference is that `bboutools` methods are parametric, while `bbouretro` methods are non-parametric. 
Parametric methods assume that the data are drawn from a pre-defined statistical distribution, i.e., the binomial distribution in the case of survival and recruitment models. 
Inference is based on the underlying statistical model, which allows for inference on statistical significance of model parameters. 
For the non-parametric methods in `bbouretro`, which do not assume an underlying statistical model, estimates are based on simple ratios, with variances estimated using approximation formulas (survival) or bootstrap resampling methods. 

Advantages of the parametric approach include:   
- year can be modeled as a random effect, where parameter values are assumed to be drawn from a common underlying distribution and information is shared among years.  
- models can include estimation of an underlying trend.  
- uncertainty around survival estimates can be estimated in cases with 0 mortalities in a year (where this is not possible in `bbouretro`).  

In addition, advantages of using a Bayesian framework include:  
- models can incorporate prior knowledge, which is especially useful when data are sparse.  
- posterior distributions of parameters can be combined to produce derived parameters (e.g., population growth) with full information about uncertainty retained.  

A `bboutools` survival model including a year random effect and trend takes the form
$$
\begin{aligned}
d_{ij} & \sim \text{Binomial}(1 - \widehat{S_{ij}}, r_{ij}) \\
\text{logit}(\widehat{{S}_{ij}}) & = \beta_{0} + \alpha_{i} + \delta_{j} + \beta_{1} \cdot Year_{j} \\
\alpha_{i} & \sim \text{Normal}(0, \sigma_{\alpha}) \\
\delta_{j} & \sim \text{Normal}(0, \sigma_{\delta}) \\
\end{aligned}
$$

where $d_{i,j}$ is the number of mortalities in the $i^{th}$ month and $j^{th}$ year, $r_{i,j}$ is the number of collared individuals at the start of the month, $\wide{hat{S}_{ij}}$ is the survival probability, $\alpha_i$ is a monthly random effect with SD $\sigma_{\alpha}$, $\delta_i$ is an annual random effect with SD $\sigma_{\delta}$ and $\beta_{1}$ represents the trend. 

A `bboutools` recruitment model including annual random effect and trend takes the form
$$
\begin{aligned}
Calves_{j} & \sim \text{Binomial}(X_{j}, AdultFemales_{j}) \\
\text{logit}(\delta_{j}) & = \beta_{0} + \alpha_{j} + \beta_{j} \cdot Year_{j} \\
\alpha_{j} & \sim \text{Normal}(0, \sigma_{\alpha}) \\
FemaleYearlings_{j} & \sim \text{Binomial}(sex\_ratio, Yearlings_{j}) \\
Cows_{j} & \sim \text{Binomial}(adult\_sex\_ratio, CowsBulls_{j}) \\
AdultFemalesOther_{j} & \sim \text{Binomial}(adult\_sex\_ratio, AdultsUnknown_{j}) \\
AdultFemales_{j} & = FemaleYearlings_{j} + Cows_{j} + AdultFemalesOther_{j} \\
\end{aligned}
$$

where $X_{j}$ is the calves per adult female in the $j^{th}$ year, $\alpha_{j}$ is an annual random effect with SD $\sigma_{\alpha}$ and $\beta_{1}$ represents the trend. 

The model includes demographic stochasticity. 
Groups are aggregated by year prior to model fitting.
The sex ratio is fixed and can be adjusted by the user, with default of 0.5.
The adult female proportion can be estimated from counts of cows and bulls or fixed, with a default of 0.65, which accounts for higher mortality of males.

Models are identical for ML and Bayesian frameworks, although methods for parameter estimation and interpretation of uncertainty differ, prior information can be incorporated in the Bayesian framework, and prediction of derived parameters with uncertainty (e.g., population growth) is not implemented for ML.

We compared estimates from `bbouretro` and `bboutools` methods on [empirical data](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html).
`bbouretro` methods yield similar estimates to Bayesian fixed-effects models with uninformative priors.
As well, ML and Bayesian models yield similar estimates with uninformative priors.
By default, `bboutools` uses uninformative priors and these can be adjusted by the user. 
Estimates from random effects models tend to differ from traditional and fixed effect models. 
This is explored in more detail below.

Data simulation (i.e., with `bbousims`) allows for comparison of various methods' ability to recover known parameter values. 
[We compared](https://poissonconsulting.github.io/bbousuite/articles/simulations.html) `bbouretro` methods with `bboutools` Bayesian models with fixed or random year effects. 

![](figures/methods-compare.png)  
*<font size="-1">Figure 2. Comparison of traditional and Bayesian estimates of survival, recruitment and λ by year.</font>*

In general, the Bayesian random effects model performed best. 
Figures 3 shows the distribution of bias in estimates of population growth from 100 simulations, 20 years and 5 sample size scenarios. 
The random effects model has the smallest spread in bias, especially at lower sample sizes.

![](figures/lambda-bias.png)
*<font size="-1">Figure 3. Bias (% difference) in annual survival point estimates and known survival for 100 simulations and 20 years, by sample size and statistical method.</font>*

Random effect models exhibit 'shrinkage', which causes more extreme estimates to be pulled towards the grand mean [@kery_bayesian_2011].
This is particularly true when underlying data are sparse.
With higher sample size in each group, the difference between random and fixed effects model estimates is diminished. 
The simulation analysis demonstrates that the tendency to be skeptical of extreme values at low sample sizes is desirable, as these values are likely to result from the sampling process rather than represent the true values. 

The Bayesian methods in `bboutools` are proposed as a standardized method for comparing estimates across jurisdictions.  
In particular, the random effects model is recommended by default when there are $\geq$ 5 years of data [@kery_bayesian_2011]. 

# Acknowledgements

We acknowledge contributions from Alan Constant.
Development of `bbousuite` was funded by the Province of Alberta and Environment and Climate Change Canada.

# References


# The `bboutools` approach uses heirarchical Generalized Linear Models to estimate survival and recruitment. 

Survival is estimated from the monthly fate of collared adult females using the staggered entry Kaplan-Meier method [@pollock_survival_1989].  

$$ \widehat{{S}_{ij}} = 1 - \frac{d_{ij}}{r_{ij}} $$

where $\widehat{{S}_{ij}}$ is the survival probability for the $i^{th}$ month and $j^{th}$ year, $d_{ij}$ is the number of mortalities during the period and $r_{ij}$ is the number of collared individuals at the start of the period.

Annual survival $\widehat{S_j}$ is estimated as 
$$\widehat{S_j} = \prod_{i=1}(\widehat{{S}_{ij}})$$

There is an option in both `bboutools` and `bbouretro` to include uncertain mortaliites in the total mortalities summed prior to model fitting. 

Recruitment is estimated from annual composition surveys of boreal caribou groups with methods following DeCesare et al. [-@decesare_estimating_2012] 

$$R_{\Delta_j} = \frac{X_j \cdot sex\_ratio}{1 + X_j \cdot sex\_ratio}$$

where $X_j$ is the annual calves per adult female and $R_{\Delta_j}$ is the annual recruitment, accounting for recruitment of calves into the yearling/adult age class at the end of the caribou year.

Population growth ($\lambda$) is estimated using the Hatter-Bergerud method [@hatter_moose_1991].

$$\lambda = \frac{\widehat{S}}{1-R_\Delta}$$


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