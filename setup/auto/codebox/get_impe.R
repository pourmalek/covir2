# get_impe.R 

# get date of te latest IMPE update 


library(rvest)
library(stringr)
library(xml2)

page <- read_html("https://github.com/mrc-ide/global-lmic-reports/tree/master/data")

page %>%
  html_nodes("a") %>%       # find all links
  html_attr("href") %>%     # get the url
  str_subset("\\.csv.zip") %>% # find those that end in .csv.zip
  .[[1]]                    # return url of the first link


tmp[tmp %>%                 # return url of the latest link
      basename() %>%
      substr(1, 10) %>%
      as.Date() %>% which.max()]

tmp %>%                     # return date of the latest link
  basename() %>%
  substr(1, 10) %>%
  as.Date() %>% max()


