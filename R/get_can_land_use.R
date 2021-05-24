#' Download raster of land-use (Canada only)
#'
#' @param years vector of selected years (numeric) or or several 1990, 2000 or 2010.
#' @param zones UTM zones. Relevant zones are 7 to 22 (for Canada). 
#' @param path path to the folder where files will be stored.
#'
#' @references 
#' <https://open.canada.ca/data/en/dataset/18e3ef1a-497c-40c6-8326-aac1a34a0dec>
#' <https://www.agr.gc.ca/atlas/supportdocument_documentdesupport/aafcLand_Use/en/ISO_19131_Land_Use_1990__2000_2010_Data_Product_Specifications.pdf>
#'
#' @export
#' @examples
#' \dontrun{
#'  library(raster)
#'  image(raster(get_can_land_use(2010, 18)))
#' }

get_can_land_use <- function(years, zones, path = ".") {
  
  stopifnot(years %in% c(1990, 2000, 2010))
  stopifnot(zones %in% seq(7, 22))
  years <- unique(years)
  zones <- unique(zones)

  for (i in years) {
    for (j in zones) {
      fl <- sprintf("IMG_AAFC_LANDUSE_Z%02d_%04d.zip", j, i)
      tmp <- glue(sprintf("%04d", i), .Platform$file.sep, fl)
      msgInfo("year", style_bold(i), " zone", style_bold(j))
      zout <- glue(tempdir(), .Platform$file.sep, fl)
      dl_check(url = paste0(lu_url, tmp), destfile = zout)
      out <- unzip(zout, exdir = path)
      msgSuccess("File extracted")
    }
  }
  
  invisible(out[grepl("\\.tif$", out)])
}
