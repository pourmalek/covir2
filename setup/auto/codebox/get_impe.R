
# get_impe

# get date of the latest IMPE update 

library(rvest)
library(stringr)
library(xml2)

page <- read_html("https://github.com/mrc-ide/global-lmic-reports/tree/master/data")

page %>%
  html_nodes("a") %>%             # find all links
  html_attr("href") %>%           # get the url
  str_subset("\\.csv.zip") -> tmp # find those that end in .csv.zip

tmp[tmp %>%                       # return url of the latest link
      basename() %>%
      substr(1, 10) %>%
      as.Date() %>% which.max()]

tmp %>%                           # return date of the latest link
  basename() %>%
  substr(1, 10) %>%
  as.Date() %>% max()

write.csv(tmp, file = "get_impe.csv")
