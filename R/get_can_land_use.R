#' Download raster of land-use (Canada only)
#'
#' @param years vector of selected years (numeric) or or several 1990, 2000 or 2010.
#' @param zones UTM zones. Relevant zones are 7 to 22 (for Canada). 
#' @param path path to the folder where files will be stored.
#'
#' @references 
#' <https://open.canada.ca/data/en/dataset/18e3ef1a-497c-40c6-8326-aac1a34a0dec>
#'
#' @export
#' @examples
#' \dontrun{
#'  image(raster(get_can_land_use(1990, 7)))
#' }

get_can_land_use <- function(years, zones, path = ".") {
  
  stopifnot(years %in% seq(1990, 2000, 2010))
  stopifnot(zones %in% seq(7, 22))
  years <- unique(years)
  zones <- unique(zones)

  for (i in years) {
    for (j in zones) {
      tmp <- sprintf("%04d/IMG_AAFC_LANDUSE_Z%02d_%04d.zip", i, j, i)
      msgInfo("year", style_bold(i), " zone", style_bold(j), " ", 
        appendLF = FALSE)
      zout <- tempfile(fileext = ".zip")
      curl_download(paste0(luurl, tmp), destfile = zout)
      unzip(zout, exdir = path)
      unlink(zout)
      msgSuccess("")
    }
  }
  
  invisible(0)
}
