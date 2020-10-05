context("get land use")

test_that("Expected error", {
  expect_error(get_can_land_use(1991, 7), 
    "years %in% seq(1990, 2000, 2010) is not TRUE", fixed = TRUE)
  expect_error(get_can_land_use(1990, 6), 
    "zones %in% seq(7, 22) is not TRUE", fixed = TRUE)
  dir <- tempdir()
  res <- get_can_land_use(1990, 7, path = dir)
  expect_equal(res, 0)
  expect_true(file.exists(paste0(dir, "/IMG_AAFC_LANDUSE_Z07_1990.tif")))
})
#