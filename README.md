
<!-- README.md is generated from README.Rmd. Please edit that file -->
ectotemp
========

[![Build Status](https://travis-ci.org/wouterbeukema/ectotemp.svg?branch=master)](https://travis-ci.org/wouterbeukema/ectotemp)

Easy and rapid quantitative estimation of small terrestrial ectotherm temperature regulation effectiveness in R.
----------------------------------------------------------------------------------------------------------------

ectotemp is built on classical formulas that evaluate temperature regulation by means of various indices. Options for bootstrapping and permutation testing are included to test hypotheses about divergence between organisms, species or populations.

ectotemp builds on work by Hertz et al. (1993, and references therein), Christian and Weavers (1996), and Blouin-Demers and Weatherhead (2001). Users of this package do not need to be particularly experienced in R, but are expected to be familiar with the background, appropriate choice, and caveats of the available functions (Hertz et al. 1993, Christian and Weavers 1996, Wills and Beaupre 2000, Blouin-Demers and Nadeau 2005).

The aim of the ectotemp package is to facilitate easy and rapid estimation of small, terrestrial ectotherm temperature regulation effectiveness after data describing field-active body temperatures (*T*<sub>b</sub>), environmental (operative) temperatures (*T*<sub>e</sub>) and preferred temperatures (the set-point range, *T*<sub>set</sub>) have been collected. The package provides functions for the following types of analyses:

-   The **thermal quality of the habitat (*d*<sub>e</sub>)** and associated descriptive statistics, which estimate the degree to which environmental temperature matches the set-point range;

-   The **accuracy of temperature regulation (*d*<sub>b</sub>)** and associated descriptive statistics, which estimate the degree to which ectotherms experience body temperature outside of their set-point range;

-   Choice between several approaches to **calculate effectiveness of temperature regulation (*E*)**, including bootstrap resampling of the original distributions of *T*<sub>b</sub> and *T*<sub>e</sub> to determine confidence interval for the mean, and permutation tests for between-population or species comparisons;

-   **Exploitation of the thermal environment (Ex)**, i.e., the amount of time when field body temperatures (*T*<sub>b</sub>) are within the set-point range, relative to the total amount of time during which this could have been possible as indicated by operative temperatures (*T*<sub>e</sub>).

Installation
------------

The released version of ectotemp can be installed from CRAN with:

``` r
install.packages("ectotemp")
```

Or the latest, development version from GitHub with:

``` r
library(devtools)
install_github("wouterbeukema/ectotemp")
```

References
----------

Blouin-Demers, G., & Weatherhead, P. J. (2001). Thermal ecology of black rat snakes (*Elaphe obsoleta*) in a thermally challenging environment. Ecology, 82(11), 3025-3043.<br/> Blouin-Demers, G., & Nadeau, P. (2005). The cost-benefit model of thermoregulation does not predict lizard thermoregulatory behavior. Ecology, 86(3), 560-566.<br/> Christian, K. A., & Weavers, B. W. (1996). Thermoregulation of monitor lizards in Australia: an evaluation of methods in thermal biology. Ecological monographs, 66(2), 139-157.<br/> Hertz, P. E., Huey, R. B., & Stevenson, R. D. (1993). Evaluating temperature regulation by field-active ectotherms: the fallacy of the inappropriate question. The American Naturalist, 142(5), 796-818.<br/> Wills, C. A., & Beaupre, S. J. (2000). An application of randomization for detecting evidence of thermoregulation in timber rattlesnakes (*Crotalus horridus*) from northwest Arkansas. Physiological and Biochemical Zoology, 73(3), 325-334.
