#' @importFrom curl curl curl_download
#' @importFrom glue glue
#' @importFrom sf st_read
#' @importFrom utils unzip
NULL


# HELPER

gh_url <- "https://github.com/"
ghraw_url <- "https://raw.githubusercontent.com"
gadm_url <- "https://biogeo.ucdavis.edu/data/gadm3.6/"
glue_url <- function(...) glue(..., .sep = "/", .envir = parent.frame(1))

# see graphicustils

howManyRC <- function(n) {
    n <- as.integer(n[1L])
    stopifnot(n > 0)
    ##
    sqr <- sqrt(n)
    fsq <- floor(sqr)
    nbr <- nbc <- fsq
    #
    if (sqr - fsq != 0)
        nbr <- fsq + 1
    if (n - nbr * nbc > 0)
        nbc <- fsq + 1
    #
    c(nbr, nbc)
}


last_part <- function(x) {
  tmp <- sub(".*/([[:graph:]]+)", "\\1", x)
  sub("([[:graph:]]+)\\.[[:alnum:]]+$", "\\1", tmp)
}
