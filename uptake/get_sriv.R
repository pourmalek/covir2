# get_sriv.R

# get date of the latest SRIV update 

library(rvest)
library(stringr)
library(xml2)

page <- read_html("https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts/")

page %>%
  html_nodes("a") %>%       # find all links
  html_attr("href") %>%     # get the url
  str_subset("\\.*") -> tmp # find those that end in *
 # print.default()         # return all

tail(tmp, 2)                # return url of the two latest links

tail(tmp, 1)                # return url of the latest link

write.csv(tmp, file = "get_sriv.csv")



