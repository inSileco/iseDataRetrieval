#' Download raster of land-use (Canada only)
#'
#' @param years vector of selected years (numeric) one or several among 2000,
#' 2005, 2010, 2015 or 2020.
#' @param zones UTM zones. Relevant zones are 7 to 22 (for Canada).
#' @param path path where files must be stored.
#'
#' @references
#' <https://open.canada.ca/data/en/dataset/fa84a70f-03ad-4946-b0f8-a3b481dd5248/resource/6b4a00e2-a629-4e48-9592-9ac8c779688e?inner_span=True>
#'
#' @export
#' @examples
#' \dontrun{
#' library(terra)
#' plot((rast(get_can_land_use(2010, 18))))
#' }
get_can_land_use <- function(years, zones, path = ".") {
  agr_url <- "https://agriculture.canada.ca"
  lu_path <- "atlas/data_donnees/landuse/data_donnees/tif"
  stopifnot(years %in% seq(2000, 2020, 5))
  stopifnot(zones %in% seq(7, 22))
  years <- unique(years)
  zones <- unique(zones)

  for (i in years) {
    for (j in zones) {
      fl <- sprintf("LU%04d_u%02d.zip", i, j)
      cli::cli_alert_info("year {i}, zone {j}")
      zout <- file.path(tempdir(), fl)
      print(paste(agr_url, lu_path, i, fl, sep = "/"))
      dl_check(url = paste(agr_url, lu_path, i, fl, sep = "/"), destfile = zout)
      out <- unzip(zout, exdir = path)
      cli::cli_alert_success("file extracted!")
    }
  }

  invisible(out[grepl("\\.tif$", out)])
}
