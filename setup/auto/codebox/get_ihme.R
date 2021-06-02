# get_ihme.R 

# get date of te latest IHME update 


library(rvest)
library(stringr)
library(xml2)

page <- read_html("http://www.healthdata.org/covid/data-downloads")

page %>%
  html_nodes("a") %>%       # find all links
  html_attr("href") %>%     # get the url
  str_subset("\\.zip") %>% # find those that end in .zip
  .[[1]]                    # return url of the first link


tmp[tmp %>%                 # return url of the latest link
      basename() %>%
      substr(1, 10) %>%
      as.Date() %>% which.max()]

tmp %>%                    # return date of the latest link
  basename() %>%
  substr(1, 10) %>%
  as.Date() %>% max()


