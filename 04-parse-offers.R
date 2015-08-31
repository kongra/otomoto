#!/usr/bin/env Rscript
## Created 2015-08-28

library(data.table)
library(XML)
library(kongRa)

source("03-raw-oto.R")

plistMap <- function(doc) {
  plist <- xpathSApply(doc, "//ul[@class='params-list clr']/li")
  m     <- hashmap(size = length(plist))
  for (li in plist) {
    k <- xpathSApply(li, "small/text()" , xmlValue)
    v <- xpathSApply(li, "span/text()"  , xmlValue) %or%
         xpathSApply(li, "a/span/text()", xmlValue)
    m[[k]] <- v
  }
  m
}

flistMap <- function(doc) {
  flist <- xpathSApply(
      doc, "//div[@class='features-list']/ul/li/text()", xmlValue)
  m <- hashmap(size = length(flist))
  for (f in flist) {
    m[[f]] <- TRUE
  }
  m
}

processOffer <- function(i, f, dt) {
  doc   <- htmlTreeParse(f, useInternalNodes = TRUE)
  plist <- plistMap(doc)
  flist <- flistMap(doc)

  plv <- function(p) plist[[p]] %or% NA
  flv <- function(f) flist[[f]] %or% FALSE

  set(dt, i = i, j = "Id"      , value = i)
  set(dt, i = i, j = "Brand"   , value = plv("Marka"))
  set(dt, i = i, j = "Model"   , value = plv("Model"))
  set(dt, i = i, j = "Version" , value = plv("Wersja"))
  set(dt, i = i, j = "ProdYear", value = plv("Rok produkcji"))
  set(dt, i = i, j = "Mileage" , value = plv("Przebieg"))
  set(dt, i = i, j = "FuelType", value = plv("Rodzaj paliwa"))
  set(dt, i = i, j = "Capacity", value = plv("Pojemność skokowa"))
  set(dt, i = i, j = "Horsepow", value = plv("Moc"))
}

processOffers <- function(otofiles) {
  dt <- createRawOto(length(otofiles))
  for (i in seq_along(otofiles)) {
    if (i %% 10 == 0) {
      print(paste("processing", i, "th file."))
    }

    f <- paste(OFFERSDIR, otofiles[i], sep = "")
    tryCatch(
        processOffer(i, f, dt),
        error   = printCondition(sprintf("ERROR WHEN PROCESSING %s: ", f)),
        warning = printCondition(sprintf("WARNING WHEN PROCESSING %s: ", f)))
  }
  dt
}

## ## OFFERSDIR <- "offers/"
## ## otofiles <- dir(OFFERSDIR)

set.seed(1024L)
sampleOtofiles <- sample(otofiles, size = 1e3)

## system.time(oto <- processOffers(sampleOtofiles))

## ## oto <- oto[, .(Id, Brand, Model, Version, ProdYear, Mileage,
## ##               FuelType, Capacity)]
