#!/usr/bin/env Rscript
## Created 2015-05-26

library(XML)

## GRABBING THE NUMBER OF OFFER PAGES FOR BRANDS

brands <- c(
  "acura",
  "aixam",
  "alfa-romeo",
  "aro",
  "asia",
  "aston-martin",
  "audi",
  "austin",
  "autobianchi",
  "bentley",
  "bmw",
  "brilliance",
  "bugatti",
  "buick",
  "cadillac",
  "caterham",
  "chatenet",
  "chevrolet",
  "chrysler",
  "citroen",
  "comarth",
  "dacia",
  "daewoo",
  "daihatsu",
  "de-lorean",
  "dfsk",
  "dkw",
  "dodge",
  "eagle",
  "faw",
  "ferrari",
  "fiat",
  "ford",
  "galloper",
  "gaz",
  "geely",
  "gmc",
  "gonow",
  "grecav",
  "gwm",
  "holden",
  "honda",
  "hummer",
  "hyundai",
  "infiniti",
  "isuzu",
  "iveco",
  "jaguar",
  "jeep",
  "kaipan",
  "kia",
  "lada",
  "lamborghini",
  "lancia",
  "land-rover",
  "lexus",
  "ligier",
  "lincoln",
  "lotus",
  "lti",
  "luaz",
  "mahindra",
  "maruti",
  "maserati",
  "maybach",
  "mazda",
  "mclaren",
  "mercedes-benz",
  "mercury",
  "mg",
  "microcar",
  "mini",
  "mitsubishi",
  "morgan",
  "moskwicz",
  "nissan",
  "nsu",
  "nysa",
  "oldsmobile",
  "oltcit",
  "opel",
  "peugeot",
  "piaggio",
  "plymouth",
  "polonez",
  "pontiac",
  "porsche",
  "proton",
  "rayton-fissore",
  "renault",
  "rolls-royce",
  "rover",
  "saab",
  "santana",
  "saturn",
  "scion",
  "seat",
  "shuanghuan",
  "skoda",
  "smart",
  "ssangyong",
  "subaru",
  "suzuki",
  "syrena",
  "talbot",
  "tarpan",
  "tata",
  "tatra",
  "tavria",
  "tesla",
  "toyota",
  "trabant",
  "triumph",
  "tvr",
  "uaz",
  "vauxhall",
  "volkswagen",
  "volvo",
  "warszawa",
  "wartburg",
  "weismann",
  "wolga",
  "yugo",
  "zaporozec",
  "zastawa",
  "zuk"
)

brandsPagesCounts <- function() {
  counts <- integer(length(brands))

  for (i in seq_along(brands)) {
    b <- brands[i]
    print(paste("Counting sub-pages in", b))

    url  <- paste("http://otomoto.pl/osobowe/", b, sep = "")
    page <- htmlTreeParse(url, useInternalNodes = TRUE)

    if (hasNoOffers(page)) {
      counts[i] <- 0
    } else {
      pages <- xpathSApply(page, "//span[@class='page']/text()", xmlValue)
      N <- length(pages)
      if (N == 0) {
        counts[i] <- 1
      } else {
        counts[i] <- as.integer(pages[N - 1])
      }
    }
  }

  counts
}

hasNoOffers <- function(page) {
  length (xpathSApply(page, "//div[@class='om-emptyinfo']")) != 0
}

brandsFrame = data_frame(brand = brands, pagesCount = brandsPagesCounts())

## OFFER URLs FOR BRANDS

printBrandPageURLs <- function(brand, page = 1) {
  url   <-
    paste("http://otomoto.pl/osobowe/", brand, "/?page=", page, sep = "")
  tryCatch(
    doc <- htmlTreeParse(url, useInternalNodes = TRUE),
    error = printCondition()
  )

  for (href in xpathSApply(doc, "//h3[@class='om-title']/a/@href")) {
    print(paste(href))
  }
}

printBrandURLs <- function(brand, pages) {
  for (p in 1:pages) {
    print(paste("GRABBING", brand, "page", p, "of", pages, sep = " "))
    printBrandPageURLs(brand, p)
  }
}

printOfferURLs <- function(brandsFrame) {
  frame <- filter(brandsFrame, brandsFrame$pagesCount != 0)
  by(frame, 1:nrow(frame), function (row) {
    printBrandURLs(row$brand, row$pagesCount)
  })
}

printOfferURLs(brandsFrame)
