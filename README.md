# covir2

# COVID-19 Iran Review No 2, Stata codes



README for covir2 repo

*******************************************************************************************************************
* Project: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10
* **OBJECTIVE** of Project: Get and prepare component studies' estimates for Iran, Locate peak dates and values 
*******************************************************************************************************************

*
*

* Details: This is a review study of estimates of COVID1-9 in Iran for time period December 2020 onwards. The codes in this repository get the estimtions peroformed by the compnent studies, prepare them, locate peak dates and values, and produce graphs using Stata. This repo can be used to replicate the results of the review study. 

*
*

### SUMMARY of how to use the codes in this repo

Once you have downloaded the repo to your local machine, perform the following on your *DOWNLOADED* do file:

1. Open "do Iran master.do" here covir2 / data / master / [do Iran master.do](https://github.com/pourmalek/covir2/blob/main/Data/master/do%20Iran%20master.do)
2. Edit the contents within " " of 
`global` pathcovir2 "/Users/farshadpourmalek/Downloads/covir2-main/data/"
to reflect where the directory /data/ or \data\ is located on your machine. Save the do file. 
3. Run the saved "do Iran master.do". 

*
*

* Details of do files:

Stata do files Get and prepare component studies' estimates for Iran, using the component studies' web pages that contain the estimates’ files, except for study "Soltani" using the digitized data (located here covir2 / data / Soltani / Soltani dig data.xlsx)

*
*

* Directory structure:

Do files are located in directories: 

covir2 / data / [DELP](https://github.com/pourmalek/covir2/tree/main/Data/DELP), [IHME](https://github.com/pourmalek/covir2/tree/main/Data/IHME), [IMPE](https://github.com/pourmalek/covir2/tree/main/Data/IMPE), [JOHN](https://github.com/pourmalek/covir2/tree/main/Data/JOHN), [LANL](https://github.com/pourmalek/covir2/tree/main/Data/LANL), [master](https://github.com/pourmalek/covir2/tree/main/Data/master), [merge](https://github.com/pourmalek/covir2/tree/main/Data/merge), [Soltani](https://github.com/pourmalek/covir2/tree/main/Data/Soltani), [SRIV](https://github.com/pourmalek/covir2/tree/main/Data/SRIV)

*
*

* **List of descriptive texts in other md files in this repo**

* For more details on how to use the codes, see covir2 / Data / master / [Example file path edit](https://github.com/pourmalek/covir2/blob/main/Data/master/Example%20file%20path%20edit.md)

* For description of variable name structure used in codes, see covir2 / [Variable name structure](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.md)

* For troubleshooting possible errors returned during running the codes, see covir2 / [troubleshooting] 

*
*

* See [LICENSE](https://github.com/pourmalek/covir2/blob/main/LICENSE)

*
*

[![DOI](https://zenodo.org/badge/344389637.svg)](https://zenodo.org/badge/latestdoi/344389637)




