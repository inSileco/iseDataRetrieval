# iseDataRetrieval 0.1.0

* add iso3 as a data set of the package.gss
* remove `get_climate_nam_grids()`
* raster is no longer a dependency of the package.
* remove fontawesome-related function (see R package fontawesome).
* land-use urls have been updated. 
* `get_can_land_use()` now properly checks whether the zip file has been downloaded before.
* `get_can_land_use()` now returns the path to the `.tif` file.

# iseDataRetrieval 0.0.3

* `inSilecoDataRetrieval` has been renamed `iseDataRetrieval`.
* `full.names` is now set to `TRUE` when files are listed in `extract_climate_data()`.
* `extract_climate_data()` gains an example.

# inSilecoDataRetrieval 0.0.2

* `dl_check()` introduces a file check before proceeding to download.
* add `get_can_land_use()` that retrieves land-use data for Canada.

# inSilecoDataRetrieval 0.0.1

* Added a `NEWS.md` file to track changes to the package.
* Intial functions: `get_gadm()`, `get_fa_icons()`, `get_climate_nam_grids()`