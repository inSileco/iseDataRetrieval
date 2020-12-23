#' Download GADM 3.6 data in all available format.
#'
#' @param country ISO3 code of a country, use "?" to get the full list of codes.
#' @param level administrative level, `level = 0` download administrative boundaries for the entire country. Note that maximum value taken varies among countries (5 is the maximum value encountered).
#' @param path path to the folder where files will be stored.
#' @param format either "sf", "sp", "kmz", "shp" or "gpkg" (see details).
#'
#' @details
#' * "sf" downloads a `.rds` file containing an object of class `SpatialPolygonsDataFrame`.
#' * "sp" downloads a `.rds` file containing an object of class `sf`.
#' * "kmz" downloads a `.kmz` (Keyhole Markup language Zipped) file.
#' * "shp" download an archive zip containing one ESRI shapefiles per level available.
#' * "gpkg" downloads an archive zip containing a GeoPackage file including all available levels.
#'
#' Note that if a specific  level does not exist, an HTTP error 404 will be
#' returned for the first group of files whereas for the second group the
#' archive will still be downloaded but a error will be thrown when attempting
#' reading a level that does not exist.
#'
#' @returns
#' A `"SpatialPolygonsDataFrame"` object if `format = "sp"`, otherwise an object
#' of class `sf`.
#'
#' @seealso
#' [raster::getData()]
#'
#' @references
#' <https://gadm.org/>
#'
#' @export
#' @examples
#' \dontrun{
#' can <- get_gadm("CAN", level = 1, format = "sf")
#' bel <- get_gadm("BEL", format = "gpkg")
#' }
# for (i in raster::getData('ISO3')$ISO3)
#   get_gadm(i, format = "shp", path = "~/Data/gadm")


get_gadm <- function(country, level = 0, path = ".", format = c("sf", "sp", "kmz", "shp", "gpkg")) {

  if (country == "?") {
    msgInfo("ISO3 codes for countries are as follows:")
    print(getData('ISO3'))
    return(invisible(NULL))
  } else {
    iso3 <- getData('ISO3')$ISO3
    country <- country[1L]
    stopifnot(country %in% iso3)
  }

  format <- match.arg(format)
  # parts of the url
  tmp <- switch(format,
    sf = c("Rsf", "_sf.rds"),
    sp = c("Rsp", "_sp.rds"),
    kmz = c("kmz", ".kmz"),
    shp = c("shp", "_shp.zip"),
    gpkg = c("gpkg", "_gpkg.zip")
  )

  shp_gpkg <- format %in% c("shp", "gpkg")
  if (shp_gpkg) {
    msgInfo(paste0("`", format, "`"),
      "selected, all administrative levels will be downloaded.")
  } else tmp[2] <- paste0("_", level, tmp[2])

  # file name
  fln <- paste0("gadm36_", country, tmp[2])
  # file path
  flp <- paste0(path, "/", fln)
  if (file.exists(flp)) {
    msgWarning("Looks like this file has already been downloaded.")
  } else {
    url <- paste0(gadmurl, tmp[1], "/", fln)
    msgInfo("Accessing", url)
    dl_check(url, destfile = flp)
  }

  if (shp_gpkg) {
    msgInfo("unzip archive", exdir = path)
    unzip(flp, exdir = path)
    flp = gsub('_(shp|gpkg)\\.zip$', '\\.\\1', flp)
    flb = gsub('_(shp|gpkg)\\.zip$', '', fln)
  }

  switch(format,
     sf = readRDS(flp),
     sp = readRDS(flp),
     kmz = sf::st_read(flp),
     shp = sf::st_read(paste0(path, "/", flb, "_", level, ".shp")),
     gpkg = sf::st_read(flp, layer = paste0(flb, "_", level))
  )
}

