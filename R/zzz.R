#' @importFrom cli style_bold
#' @importFrom crayon blue yellow green red
#' @importFrom curl curl curl_download
#' @importFrom glue glue
#' @importFrom magick image_read image_read_svg
#' @importFrom memoise memoise
#' @importFrom raster extract getData raster crop
#' @importFrom rsvg rsvg_raw
#' @importFrom sf st_read
#' @importFrom utils unzip
NULL


# HELPER

gh_url <- "https://github.com/"
ghraw_url <- "https://raw.githubusercontent.com"

glue_url <- function(...) glue(..., .sep = "/", .envir = parent.frame(1))

gadm_url <- "https://biogeo.ucdavis.edu/data/gadm3.6/"

lu_url <- "https://www.agr.gc.ca/atlas/data_donnees/lcv/aafcLand_Use/tif/"

# see inSilecoMisc

msgInfo <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt), appendLF = appendLF)
  invisible(txt)
}


msgError <- function(...) {
  txt <- paste(cli::symbol$cross, ...)
  message(red(txt))
  invisible(txt)
}

msgSuccess <- function(...) {
  txt <- paste(cli::symbol$tick, ...)
  message(green(txt))
  invisible(txt)
}

msgWarning <- function(...) {
  txt <- paste(cli::symbol$warning, ...)
  message(yellow(txt))
  invisible(txt)
}


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
