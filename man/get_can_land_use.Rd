% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_can_land_use.R
\name{get_can_land_use}
\alias{get_can_land_use}
\title{Download raster of land-use (Canada only)}
\usage{
get_can_land_use(years, zones, path = ".")
}
\arguments{
\item{years}{vector of selected years (numeric) one or several among 2000,
2005, 2010, 2015 or 2020.}

\item{zones}{UTM zones. Relevant zones are 7 to 22 (for Canada).}

\item{path}{path where files must be stored.}
}
\description{
Download raster of land-use (Canada only)
}
\examples{
\dontrun{
library(terra)
plot((rast(get_can_land_use(2010, 18))))
}
}
\references{
\url{https://open.canada.ca/data/en/dataset/fa84a70f-03ad-4946-b0f8-a3b481dd5248/resource/6b4a00e2-a629-4e48-9592-9ac8c779688e?inner_span=True}
}
