#' A shortcut to download a file and check whether it was previously downloaded
#'
#' @param url URL of the file to be downloaded (see [curl::curl_download()]).
#' @param destfile destination file (see [curl::curl_download()])
#' @param ... further arguments passed to [curl::curl_download()].
#'

dl_check <- function(url, destfile, ...) {
  if (file.exists(destfile)) {
    cli::cli_alert_warning("skipped (already dowloaded)")
  } else {
    cli::cli_alert_info("Accessing <{url}>")
    curl::curl_download(url, destfile, ...)
    cli::cli_alert_success("file downloaded!")
  }
  invisible(TRUE)
}