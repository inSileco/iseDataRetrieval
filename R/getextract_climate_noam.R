#' Retrieve raster of climate data for North America and extract values
#'
#' @param geom geometry used for extraction.
#' @param year  selected year (numeric).
#' @param info a character string specifying the kind of data to be retrieved. One among "bio", "cmi", "mint", "maxt", "pcp", "sg". Default is set to "bio".
#' @param res resolution of the raster files to be downloaded in arcsec (60 or 300arcsed, i.e. 10km2 or 2km2, default is set to 300).
#' @param path path to the folder where files are stored.
#' @param outdir output directory.
#' @param rm_zip a logical. Should zip files be removed?
#' @param rm_files a logical. Should raster files be removed after extraction?
#' @param quiet Should extra information reported on progress be suppressed?
#'
#' @references
#' <ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids>
#' <https://climate.weather.gc.ca/>
#' @export

getextract_climate_noam <- function(geom, year = 1900,
  info =  c("bio", "cmi", "mint", "maxt", "pcp", "sg"), res = 300,
  path = "climateData/", outdir = "output/", rm_zip = TRUE, rm_files = TRUE,
  quiet = FALSE) {

  stopifnot(res %in% c(60, 300))
  dir.create(path, showWarnings = FALSE)
  dir.create(outdir, showWarnings = FALSE)
  info <- match.arg(info)
  #
  get_unique_noam(year, info, res, path, rm_zip, quiet)
  extract_unique_noam(geom, year, info, res, path, outdir, rm_files, quiet)
  invisible(NULL)
}



get_unique_noam <- function(year, info, res, path, rm_zip, quiet) {

  beg <- paste0("ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles",
    res, "/")
  end <- paste0("_", res, "arcsec.zip")

  if (!quiet) cat("==> downloading data for", year," .....\n")
  zout <- paste0(path, "/", info, year, ".zip")
  download.file(paste0(beg, info, year, end), destfile = zout, quiet = quiet)
  unzip(zout, exdir = path)
  if (rm_zip) unlink(zout)
  if (!quiet) cat(".... done!\n")
  invisible(NULL)
}

extract_unique_noam <- function(geom, year, info, res, path, outdir, rm_files, quiet) {
  nm_fo <- paste0(path, year)
  pat <- paste0(info, ".*.asc$")
  vc_fl <- list.files(nm_fo, pattern = pat, full.names = TRUE)
  if (!quiet) cat("==> extracting data ..................")
  # extract (NB st_transform() done automatically with a warning)
  val <- lapply(lapply(vc_fl, raster), function(x) extract(x, y =  geom))
  tmp <- as.data.frame(do.call(cbind, val))

  names(tmp) <- paste0(
    gsub(".asc", "", list.files(nm_fo, pattern = pat)),
    "_", year)
  saveRDS(tmp, paste0(outdir, info, "_", year, "_", res, ".rds"))
  # remove folder
  if (rm_files) unlink(nm_fo, recursive = TRUE)
  if (!quiet) cat(".... done!\n")
  invisible(NULL)
}

