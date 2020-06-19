#' Download raster of climate data for North America
#'
#' @param years vector of selected years (numeric), all years from 1900 until 2015 are available.
#' @param infos character string specifying the data to be downloaded. Available data are "bio", "cmi", "mint", "maxt", "pcp" and "sg" (see details).
#' @param res resolution of the raster files to be downloaded in arcsec (60 or 300arcsed, i.e. 10km2 or 2km2), default is set to 300.
#' @param path path to the folder where files are stored.
#'
#' @details
#' * `bio` : 19 bioclimatic variables,
#' * `cmi` : monthly Climate Moisture Index,
#' * `mint`: monthly minimum temperature,
#' * `maxt`: monthly maximum temperature,
#' * `pcp` : monthly precipitation,
#' * `sg`  : 16 additional bioclimatic variables.
#'
#' @references
#' <ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids>
#' <https://climate.weather.gc.ca/>
#'
#' @export
#' @examples
#' \dontrun{
#'  get_climate_nam_grids(2014:2015)
#'  get_climate_nam_grids(2000:2001, c("bio", "sg", "pcp"))
#' }

get_climate_nam_grids <- function(years, infos = "bio", res = 300, path = ".") {

  stopifnot(all(infos %in% c("bio", "cmi", "mint", "maxt", "pcp", "sg")))
  infos <- unique(infos)
  stopifnot(res %in% c(60, 300))
  #
  basurl <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles"
  beg <- paste0(basurl, res, "/")
  end <- paste0("_", res, "arcsec.zip")
  # year available: from 1900 to 2017
  for (info in infos) {
    msgInfo("Downloading grids of", style_bold(info))

    for (year in years) {
      msgInfo("info:", style_bold(info), "year:", style_bold(year))
      zout <- tempfile(fileext = ".zip")
      curl_download(paste0(beg, info, year, end), destfile = zout)
      unzip(zout, exdir = path)
      unlink(zout)
      msgSuccess("done!")
    }
  }

  invisible(0)
}

