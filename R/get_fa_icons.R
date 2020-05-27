#' Retrieve (free) font awesome icons.
#'
#' @param names icons names
#' @param format image format either "svg" (default) or "png".
#' @param res resolution for png files (ignored for svg), either 16, 22, 24, 32, 48, 64, 128, or 256.
#' @param pattern character string containing a regular expression (see [grep()]).
#'
#' @reference
#' <https://fontawesome.com/>
#' <https://github.com/encharm/Font-Awesome-SVG-PNG>
#'
#' @return
#' An objet of class `magick-image`, see [magick::image_read()].
#'
#' @export
#' @examples
#' val <- search_fa_icons("^y")
#' icons <- get_fa_icons(val, "png", res = 256)
#' plot(magick::image_append(icons))

get_fa_icons <- function(names, format = c("svg", "png"), res = 128) {

    if (missing(names)) {
        msgWarning("`names` is empty, returning the list of available names.")
        msgInfo("See also `search_fa_icons()`.")
        return(fa_names())
    }

    if (!all(names %in% fa_names())) {
        msgWarning("`names` contains invalid names!")
    }

    format <- match.arg(format)

    if (format == "svg") {
        urls <- paste0(ghurlraw,
            "/inSileco/Font-Awesome-SVG-PNG/master/black/svg/", names, ".svg")
        image_read_svg(urls)
    } else {
        res <- match.arg(as.character(res),
            as.character(c(16, 22, 24, 32, 48, 64, 128, 256)))
        urls <- paste0(ghurlraw,
            "/inSileco/Font-Awesome-SVG-PNG/master/black/png/", res, "/",
            names, ".png")
        image_read(urls)
    }

}


#' @describeIn get_fa_icons Search icon names.
#' @export
search_fa_icons <- function(pattern) {
    icn <- fa_names()
    icn[grepl(pattern, icn)]
}

get_fa_names <- function() {
    con <- curl(pasteURL(ghurl,
        "inSileco/Font-Awesome-SVG-PNG/tree/master/black/svg"))
    open(con)
    icn <- readLines(con)
    close(con)
    icn <- icn[unlist(lapply(icn, function(x) grepl("\\.svg\">", x)))]
    unlist(lapply(icn[-1],
            function(x)
                sub(".*black/svg/.*\\.svg\">(.*)\\.svg</a>.*", "\\1", x)
        ))
}


fa_names <- memoise(get_fa_names)



