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
output: 
  rticles::joss_article: default
csl: apa.csl
journal: JOSS
tags:
  - boreal caribou
  - Bayesian
  - maximum likelihood
  - survival
  - recruitment
  - population growth
---

# Summary

Although many animal populations are managed based on their abundance [@williams_analysis_2002], reliable abundance estimates can be difficult to obtain for mobile herding populations with large ranges such as boreal caribou (*Rangifer tarandus caribou*).
Consequently, such populations are commonly managed based on their population growth rate ($\lambda$), which can be estimated from the population recruitment ($R$) and adult female survival ($S$) rates [@hatter_moose_1991] using the following equation. 

$$\lambda = \frac{S}{1- R}$$

The `bbou` suite is a set of R packages [@r_core_team_2023] to facilitate simulation and analysis of boreal caribou survival and recruitment data to estimate population growth.  

It consists of:  
- [`bboudata`](https://poissonconsulting.github.io/bboudata/), a collection of simulated and anonymized empirical survival and recruitment datasets.  
- [`bboutools`](https://poissonconsulting.github.io/bboutools/), tools to estimate population growth in a Bayesian or Maximum Likelihood (ML) framework, implemented under the hood using the `Nimble` R package [@de_valpine_programming_2017].  
- [`bboushiny`](https://poissonconsulting.github.io/bboushiny/), a Graphical User Interface (GUI) to `bboutools` (\autoref{fig:bboushiny}).    
- [`bbouretro`](https://poissonconsulting.github.io/bbouretro/), tools to estimate population growth using traditional frequentist methods.  
- [`bbousims`](https://poissonconsulting.github.io/bbousims/), tools to simulate survival and recruitment data from hypothetical collaring and composition surveys.  

Each R package has a website with function documentation and a 'Get Started' guide.
There are also several vignettes, including on `bboutools` [analytical methods](https://poissonconsulting.github.io/bboutools/articles/methods.html) and [prior selection](https://poissonconsulting.github.io/bboutools/articles/priors.html); `bbouretro` [analytical methods](https://poissonconsulting.github.io/bbouretro/articles/retro-methods.html); using [`bbousims` with `bboutools`](https://poissonconsulting.github.io/bbousims/articles/bboutools.html); and comparison of Bayesian and traditional method estimates with [empirical](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html) and [simulated](https://poissonconsulting.github.io/bbousuite/articles/simulations.html) data. 

![A screenshot of the bboushiny GUI. \label{fig:bboushiny}](figures/bboushiny-survival.png)

# Statement of need

Boreal caribou are found in most provinces and territories in Canada and have been listed as threatened since 2003 [@ECCC_2023].
Each jurisdiction has their own monitoring program responsible for boreal caribou.
Numerous methods have been used to estimate population growth, which can make cross-jurisdictional conversations on the health of the species complex. 

The suite of R packages in `bbousuite` aim to address this problem.
`bboutools` provides a standardized methodology with simple, general models and sensible defaults for estimating survival, recruitment and population growth that can be compared across jurisdictions.
In addition, `bboushiny` provides access to `bboutools` functionality in a GUI; `bbouretro` facilitates comparison with traditional methods; and `bbousims` facilitates comparison of various methods' ability to recover known parameter values from simulated data. 

There is an existing web-based application for estimating boreal caribou population growth rate [@eacker_webbased_2019]. 
However, users reported that it was difficult to use, especially if not familiar with Bayesian statistics, and had too many options to be considered a standarized method.  

The `caribouMetrics` R package, and associated shiny app `BayesianCaribouDemographicProjection`, also have functionality to estimate boreal caribou demographic parameters.  
However, the primary goal of these tools is to forecast boreal caribou population under different monitoring and disturbance scenarios [@dyson_2022].

# Overview of methods

Despite key methodological differences, which are explained in more detail below, `bboutools` and `bbouretro` use the same underlying equations to estimate survival, recruitment and population growth. 
Survival is estimated from the monthly fate of collared adult females using the staggered entry Kaplan-Meier method [@pollock_survival_1989], with an option to include uncertain mortaliites in the total monthly mortalities summed prior to model fitting. 
Recruitment is estimated from annual composition surveys following methods in DeCesare et al. [-@decesare_estimating_2012], where the adjusted recruitment accounts for recruitment of calves into the yearling/adult age class at the end of the caribou year.
Population growth ($\lambda$) is estimated using the Hatter-Bergerud method [@hatter_moose_1991].
Both `bboutools` and `bbouretro` allow the user to adjust the start month of the biological year and data are aggregated by biological year prior to model fitting.

A full comparison of `bboutools` and `bbouretro` statistical methods is beyond the scope of this paper.
A key difference is that `bboutools` methods are parametric, whereas `bbouretro` methods are non-parametric. 
Parametric methods assume the data (sample) are drawn from a population which can be described by a statistical distribution, i.e., the binomial in the case of survival and recruitment models. 
Inference is based on the underlying statistical model, which allows for inference on statistical significance of model parameters. 
For non-parametric methods used in `bbouretro`, estimates are based on simple ratios, with variances estimated using approximation formulas (survival) or bootstrap resampling methods. 

With a parametric approach:   
- year can be modeled as a random effect, where individual year effects are assumed to be drawn from a common underlying distribution and information is shared among years.  
- models can include an underlying trend.  
- uncertainty is more precise and reliable.  
- uncertainty around survival estimates can be estimated in cases with 0 mortalities in a year.  

In addition, with a Bayesian framework:  
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

where $d_{i,j}$ is the number of mortalities in the $i^{th}$ month and $j^{th}$ year, $r_{i,j}$ is the number of collared individuals at the start of the month, $\widehat{{S}_{ij}}$ is the survival probability, $\alpha_i$ is a monthly random effect with SD $\sigma_{\alpha}$, $\delta_i$ is an annual random effect with SD $\sigma_{\delta}$ and $\beta_{1}$ represents the trend. 

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
The adult female proportion can be estimated from counts of cows and bulls or fixed, with a default of 0.65, which accounts for higher mortality of males [@smith_2004].

We compared estimates from `bbouretro` and `bboutools` on anonymized empirical and simulated data.

[Empirical comparisons](https://poissonconsulting.github.io/bbousuite/articles/empirical-comparisons.html) demonstrate that `bbouretro` methods yield similar estimates to Bayesian fixed-effects models with uninformative priors (\autoref{fig:empirical}).
By default, `bboutools` uses uninformative priors and these can be adjusted by the user. 
Estimates from random effects models tend to provide more reliable estimates than traditional and fixed effect models.
This is explored in more detail below.

![Comparison of traditional and Bayesian estimates of survival and recruitment by year. The bars represent 95% confidence/credible intervals.\label{fig:empirical}](figures/methods-compare.png)  

Data simulation (i.e., with `bbousims`) allows for comparison of various methods' ability to recover known parameter values (i.e., with bias, precision, coverage). 

[Our analysis](https://poissonconsulting.github.io/bbousuite/articles/simulations.html) demonstrates that the Bayesian random effects model generally performs best. 
For example, a plot of the of bias in point estimates of population growth for 100 simulations and 20 years shows that the random effects model has the greatest precision, especially at lower sample sizes (\autoref{fig:bias}).

![Bias (% difference) in annual population growth point estimates and known population growth for 100 simulations and 20 years, by sample size and statistical method.\label{fig:bias}](figures/lambda-bias.png)

Random effect models exhibit 'shrinkage', which causes more extreme estimates to be pulled towards the group mean, especially when underlying data are sparse [@kery_bayesian_2011].
With higher sample size in each group, the difference between random and fixed effects model estimates is diminished. 
The simulation analysis demonstrates that the tendency to be skeptical of extreme values at low sample sizes is desirable, as these values are likely to result from the sampling process rather than represent the true values. 

The Bayesian methods in `bboutools` are proposed as a standardized method for comparing estimates across jurisdictions.
In particular, the random effects model is recommended by default when there are $\geq$ 5 years of data [@kery_bayesian_2011]. 

# Acknowledgements

We acknowledge contributions from Alan Constant, Sarah Lyons, Colton Stephens and Nicole Hill.
Development of `bbousuite` was funded by the Province of Alberta and Environment and Climate Change Canada.

# References
