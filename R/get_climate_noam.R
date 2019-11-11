#' Retrieve raster of climate data for North America
#'
#' @param years vector of selected years (numeric).
#' @param info a character string specifying the kind of data to be retrieved. One among "bio", "cmi", "mint", "maxt", "pcp", "sg". Default is set to "bio".
#' @param res resolution of the raster files to be downloaded in arcsec (60 or 300arcsed, i.e. 10km2 or 2km2, default is set to 300).
#' @param path path to the folder where files are stored.
#' @param rm_zip a logical. Should zip files be removed? Default is set to `TRUE`.
#' @param quiet Should extra information reported on progress be suppressed?
#'
#' @references
#' <ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids>
#' <https://climate.weather.gc.ca/>
#' @export
#' @importFrom utils download.file unzip

get_climate_noam <- function(years = 1900:2015,
  info =  c("bio", "cmi", "mint", "maxt", "pcp", "sg"), res = 300,
  path = "climateData/", rm_zip = TRUE, quiet = FALSE) {

  stopifnot(res %in% c(60, 300))
  dir.create(path, showWarnings = FALSE)
  #
  basurl <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles"
  #
  info <- match.arg(info)
  beg <- paste0(basurl, res, "/")
  end <- paste0("_", res, "arcsec.zip")
  # year available: from 1900 to 2017
  for (year in years) {
    cat("==>", year, "\n")
    zout <- paste0(path, "/", info, year, ".zip")
    download.file(paste0(beg, info, year, end), destfile = zout, quiet = quiet)
    unzip(zout, exdir = path)
    if (rm_zip) unlink(zout)
    cat("done\n")
  }
}
