#!/usr/bin/env Rscript
## Created 2015-08-28

library(data.table)
library(XML)
library(kongRa)

source("03_raw_oto.R")

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

processOffer <- function(i, file, oto) {
  doc   <- htmlTreeParse(file, useInternalNodes = TRUE)
  plist <- plistMap(doc)
  flist <- flistMap(doc)

  plv <- function(p) plist[[p]] %or% NA
  flv <- function(f) flist[[f]] %or% FALSE

  tak2TRUE    <- function(b) ifelse(b == "Tak", TRUE, NA)
  tak2logical <- function(b) ifelse(b == "Tak", TRUE,
                                    ifelse(b == 'Nie', FALSE, NA))

  set(oto, i = i, j = "Id"      , value = i)
  set(oto, i = i, j = "Brand"   , value = plv("Marka"))
  set(oto, i = i, j = "Model"   , value = plv("Model"))
  set(oto, i = i, j = "Version" , value = plv("Wersja"))
  set(oto, i = i, j = "ProdYear", value = plv("Rok produkcji"))
  set(oto, i = i, j = "Mileage" , value = plv("Przebieg"))
  set(oto, i = i, j = "FuelType", value = plv("Rodzaj paliwa"))
  set(oto, i = i, j = "Capacity", value = plv("Pojemność skokowa"))
  set(oto, i = i, j = "Horsepow", value = plv("Moc"))
  set(oto, i = i, j = "Gearbox" , value = plv("Skrzynia biegów"))

  # TODO: DPF może się pojawiać również w dodatkowych opisach oferty.
  set(oto, i = i, j = "DPF"     , value = tak2TRUE(plv("Filtr cząstek stałych")))

  set(oto, i = i, j = "Damaged" , value = tak2TRUE(plv("Uszkodzony")))
}

processOffers <- function(otofiles) {
  oto <- createRawOto(length(otofiles))
  for (i in seq_along(otofiles)) {
    if (i %% 10 == 0) {
      print(paste("processing", i, "th file."))
    }

    file <- paste(OFFERSDIR, otofiles[i], sep = "")
    tryCatch(
        processOffer(i, file, oto),
        error   = printCondition(sprintf("ERROR WHEN PROCESSING %s: "  , file)),
        warning = printCondition(sprintf("WARNING WHEN PROCESSING %s: ", file)))
  }
  oto
}

OFFERSDIR <- "offers/"
# otofiles <- dir(OFFERSDIR)

# set.seed(1024L)
# sampleOtofiles <- sample(otofiles, size = 1e3)

## system.time(oto <- processOffers(sampleOtofiles))

## ## oto <- oto[, .(Id, Brand, Model, Version, ProdYear, Mileage,
## ##               FuelType, Capacity)]
