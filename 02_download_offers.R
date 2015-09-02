#!/usr/bin/env Rscript
## Created 2015-05-27

library(dplyr)

offers <- tbl_df(read.table(file             = "offers.urls",
                            header           = TRUE,
                            stringsAsFactors = FALSE)) %>% distinct

downloadOffer <- function(url, file) {
  print(paste("DOWNLOADING INTO", file, "URL", url))
  tryCatch(
      download.file(url = url, destfile = file, quiet = TRUE),
      error = printCondition())
}

downloadOffers <- function(urls) {
  for (i in seq(urls)) {
    downloadOffer(url = urls[i], file = sprintf("offers/%06d.html", i))
  }
}
