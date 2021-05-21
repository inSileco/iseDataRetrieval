#' A shortcut to download a file and check whether it was previously downloaded
#'
#' @param url URL of the file to be downloaded (see [curl::curl_download()]).
#' @param destfile destination file (see [curl::curl_download()])
#' @param ... further arguments passed to [curl::curl_download()].
#'

dl_check <- function(url, destfile, ...) {
  if (file.exists(destfile)) {
    msgWarning("skipped (already dowloaded)")
  } else {
    msgInfo("Accessing", url)
    curl::curl_download(url, destfile, ...)
    msgSuccess("file downloaded!")
  }
  invisible(TRUE)
}