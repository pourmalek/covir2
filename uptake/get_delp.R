# get_delp.R

# get date of the latest DELP update 

library(rvest)
library(stringr)
library(xml2)

page <- read_html("https://github.com/COVIDAnalytics/website/tree/master/data/predicted")

page %>%
  html_nodes("a") %>%       # find all links
  html_attr("href") %>%     # get the url
  str_subset("\\.csv") -> tmp # find those that end in .csv
# print.default()         # return all

tail(tmp, 2)                # return url of the two latest links

tail(tmp, 1)                # return url of the latest link

write.csv(tmp, file = "get_delp.csv")




