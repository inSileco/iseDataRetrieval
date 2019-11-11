#' extract climate data
#'
#' @param years vector of selected years (numeric).
#' @param info a character string specifying the kind of data to be retrieved. One among "bio", "cmi", "mint", "maxt", "pcp", "sg". Default is set to "bio".
#' @param geom geometry used for extraction.
#' @param path path to the folder where files are stored.
#' @param outdir output directory.
#' @param base base name of the output files.
#' @param quiet Should extra information reported on progress be suppressed?
#' @param rm_dir Should data folder be removed?
#'
#' @importFrom raster raster extract
#' @export


extract_data <- function(years, info, geom, path = "climateData/",
  outdir = "output/", base = "res_", quiet = FALSE, rm_dir = TRUE) {
  ##
  dir.create(outdir, showWarnings = FALSE)
  ## pattern
  pat <- paste0(info, ".*.asc$")
  for (year in years) {
    cat("==>", year, "\n")
    nm_fo <- paste0(path, year)
    vc_fl <- list.files(nm_fo, pattern = pat, full.names = TRUE)
    # extract (NB st_transform() done automatically with a warning)
    val <- lapply(lapply(vc_fl, raster), function(x) extract(x, y =  geom))
    tmp <- as.data.frame(do.call(cbind, val))

    names(tmp) <- paste0(
      gsub(".asc", "", list.files(nm_fo, pattern = pat)),
      "_", year)
    saveRDS(tmp, paste0(outdir, base, info, "_", year, ".rds"))
    # remove files
    if (rm_dir) unlink(vc_fl, recursive = TRUE)
  }
  NULL
}