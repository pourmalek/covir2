# covir2

COVID-19 Iran Review No 2, Stata codes

README for covir2 repo

* Project: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10
* OBJECTIVE of Project: Get and prepare component studies' estimates for Iran, Locate peak dates and values

* Details: This is a review study of estimates of COVID1-9 in Iran for time period December 2020 onwards. The codes in this repository get the estimtions peroformed by the compnent studies, prepare them, locate peak dates and values, and produce graphs using Stata. This repo can be used to replicate the results. For meore details on how to use the codes, see covir2 / Data / master / Example file path edit.txt 


* SUMMARY of how to use the codes in this repo

1. Open "do Iran master.do" located in /data/master
2. Edit the contents within " " of 
global pathcovir2 "/Users/farshadpourmalek/Downloads/covir2-main/data/"
to reflect where the directory /data/ or \data\ is located on your machine. Save the do file. 
3. Run the saved "do Iran master.do". 


* Details of do files:

Stata do files Get and prepare component studies' estimates for Iran, using the component studies' web pages that contain the estimates’ files, except for study "Soltani" using the digitized data (located here \data\Soltani\Soltani dig data.xlsx)

* Directory structure:

Do files are located in directories: 

\data\ DELP, Ghanbari, IHME, IMPE, JOHN, LANL, master, merge, Soltani, SRIV.



[![DOI](https://zenodo.org/badge/344389637.svg)](https://zenodo.org/badge/latestdoi/344389637)

End. 


