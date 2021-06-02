# get_ihme.R

# get date of the latest IHME update 

library(rvest)
library(stringr)
library(xml2)

page <- read_html("http://www.healthdata.org/covid/data-downloads")

page %>%
  html_nodes("a") %>%       # find all links
  html_attr("href") %>%     # get the url
  str_subset("\\.zip") -> tmp # find those that end in .csv.zip
  # print.default()         # return all

tail(tmp, 2)                # return url of the two latest links

tail(tmp, 1)                # return url of the latest link

write.csv(tmp, file = "get_ihme.csv")
