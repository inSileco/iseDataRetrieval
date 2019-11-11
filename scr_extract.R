arg <- as.numeric(commandArgs(trailingOnly = TRUE))

# load package
devtools::load_all()

# select variables
info <- c("cmi", "bio")[arg[2]]
res <- c(60, 300)[arg[3]]

# select years
# years selection for the nodes
slc <- 1:arg[5]+(arg[1]-1)*arg[5]
years <- read.table("extData/years.txt")[slc,]
# remove missing lines
years <- years[!is.na(years)]

if (length(years)>0) {
  # retrieve data
  get_climate_noam(years, info, res)
  # plots coordinates
  pts <- readRDS("extData/plots_coords.rds")
  # extract data (create output)
  extract_data(years, info, pts, base = paste0("climdata_res", res, "_"))
}

# for (i in 1:10) {
#   cat("node", i, "\n")
#   for (j in 1:6) {
#     arg = c(i, 1, 1, j, 12, 2)
#     slc0 <- 1:arg[5] + (arg[1] - 1) * arg[5]
#     # years selection for the job
#     slc <- 1:arg[6] + (arg[4] - 1) * arg[6]
#     print(slc0[slc])
#   }
# }
# arg = c(1, 1, 1, 2, 24)
