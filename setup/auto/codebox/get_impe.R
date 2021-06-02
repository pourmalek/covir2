
# this is get_impe.R
# to get the latest estimates file from IMPE
# taken from:
# https://stackoverflow.com/questions/31517121/using-r-to-scrape-the-link-address-of-a-downloadable-file-from-a-web-page

# note: reads the first (earliest date) *.csv.zip file, not the wanted last (latest)

library(rvest)
library(stringr)
library(xml2)

page <- read_html("https://github.com/mrc-ide/global-lmic-reports/tree/master/data")

page %>%
  html_nodes("a") %>%       # find all links
  html_attr("href") %>%     # get the url
  str_subset("\\.csv.zip") %>% # find those that end in .csv.zip
  .[[1]]                    # look at the first one


