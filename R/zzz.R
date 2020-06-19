#' @importFrom cli style_bold
#' @importFrom crayon blue yellow green red
#' @importFrom curl curl curl_download
#' @importFrom magick image_read image_read_svg
#' @importFrom memoise memoise
#' @importFrom rsvg rsvg_raw
#' @importFrom utils unzip
NULL


# HELPER

ghurl <- "https://github.com/"

ghurlraw <- "https://raw.githubusercontent.com"

pasteURL <- function(...) paste(..., sep = "/")



# see inSilecoMisc

msgInfo <- function(...) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt))
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
