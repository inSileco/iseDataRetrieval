#' Feature Attributes for land-use data
#'
#' A data set containing labels, code and definition of the land-use categories.
#'
#' @format
#' A data frame with 16 rows and 3 variables:`label`, `code` and `definition`.
#'
#' @source
#' <https://www.agr.gc.ca/atlas/supportdocument_documentdesupport/aafcLand_Use/en/ISO_19131_Land_Use_1990__2000_2010_Data_Product_Specifications.pdf>

"lu_code"

#' ISO 3 code
#'
#' A data set containing iso 3 code taken from `raster` (`?raster::getData
#' ("ISO3")`).
#'
#' @format
#' A data frame with 256 rows and 2 columns.
#'
#' @source
#' <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3>

"iso3"