# inSilecoDataRetrieval

![R-CMD-check](https://github.com/inSileco/inSilecoDataRetrieval/workflows/R-CMD-check/badge.svg)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

Miscellaneous functions and scripts for data retrieval.

# Installation

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("inSileco/inSilecoDataRetrieval")
```

Once installed, load the package

``` r
library(inSilecoDataRetrieval)
```

## Retrieve Climate data

``` r
get_climate_nam_grids(1900:2015, c("bio", "cmi", "mint", "maxt", "pcp", "sg"))
```

## Retrieve Font Awesome icons

``` r
val <- search_fa_icons("^y")
icons <- get_fa_icons(val, "png", res = 256)
plot(magick::image_append(icons))
```

![](README_files/figure-gfm/fa-1.png)<!-- -->
