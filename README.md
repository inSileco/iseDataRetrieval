# inSilecoDataRetrieval

![R-CMD-check](https://github.com/inSileco/inSilecoDataRetrieval/workflows/R-CMD-check/badge.svg)

Miscellaneous functions and scripts for data retrieval.

## Retrieve Font Awesome icons

``` r
library("inSilecoDataRetrieval")
val <- search_fa_icons("^y")
icons <- get_fa_icons(val, "png", res = 256)
plot(magick::image_append(icons))
```

![](README_files/figure-gfm/fa-1.png)<!-- -->
