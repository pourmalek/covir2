# covir2

<br/><br/>

# COVID-19 Iran Review No 2, Stata codes

<br/><br/>

README for covir2 repo
<br/><br/>


*******************************************************************************************************************
* Project: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10
* **OBJECTIVE** of Project: Get and prepare component studies' estimates for Iran, Locate peak dates and values 
*******************************************************************************************************************

<br/><br/>


* Details: This is a review study of estimates of COVID1-9 in Iran for time period December 2020 onwards. The codes in this repository get the estimtions peroformed by the compnent studies, prepare them, locate peak dates and values, and produce graphs using Stata. This repo can be used to replicate the results of the review study. 

<br/><br/>



### SUMMARY of how to use the codes in this repo

1. Go to repo home page covir2 / Data / [master page](https://github.com/pourmalek/covir2)

2. Click on "Code", then "Download ZIP" to your local machine

3. Locate the DOWNLODED "covir2-main" directory on your local machine

4. Locate file "do Iran master.do" in your local directory /covir2-main/Data/master/ and run this do file. 

- Once all the codes have run, the final outputs would show up: "log Iran merge.smcl", and the last graph, with title "COVID-19 total cases, Iran, reference scenarios", with file name "graph 45 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on, CI, wo IMPE upper.gph", and if acrobat available on system, also file name "graph 45 COVID-19 total cases, Iran, reference scenarios, with DELPHI, 01dec2020 on, CI, wo IMPE upper.pdf". This signifies the end of the code implementation. These files are stoted in your local system's directory Downloads/covir2-main/Data/merge/ (Mac) or Downloads\covir2-main\Data\merge\ (Windows).

5. Go to your local directory |Downloads|covir2-main|Data|merge| and view the produced graphs (graph files start with "graph 11 COVID-19 daily deaths, Iran, reference scenarios, with DELPHI.gph, and pdf). | means / or \ depending on local OS. 

6. If Stata returns error codes, check the [troubleshooting](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

<br/><br/>

* Details of do files:

Stata do files get and prepare component studies' estimates for Iran, using the component studies' web pages that contain the estimates’ files, except for study "Soltani" using the digitized data (located at covir2 / data / Soltani / Soltani dig data.xlsx) 

<br/><br/>


* Directory structure:

Do files are located in directories: 

covir2 / data / [DELP](https://github.com/pourmalek/covir2/tree/main/Data/DELP), [IHME](https://github.com/pourmalek/covir2/tree/main/Data/IHME), [IMPE](https://github.com/pourmalek/covir2/tree/main/Data/IMPE), [JOHN](https://github.com/pourmalek/covir2/tree/main/Data/JOHN), [LANL](https://github.com/pourmalek/covir2/tree/main/Data/LANL), [master](https://github.com/pourmalek/covir2/tree/main/Data/master), [merge](https://github.com/pourmalek/covir2/tree/main/Data/merge), [Soltani](https://github.com/pourmalek/covir2/tree/main/Data/Soltani), [SRIV](https://github.com/pourmalek/covir2/tree/main/Data/SRIV)

<br/><br/>


* **List of descriptive texts in other md files in this repo**

* For description of variable name structure used in codes, see covir2 / [Variable name structure](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.md)

* For troubleshooting possible errors returned during running the codes, see covir2 / [troubleshooting](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

<br/><br/>


* See [LICENSE](https://github.com/pourmalek/covir2/blob/main/LICENSE)

<br/><br/>

[![DOI](https://zenodo.org/badge/344389637.svg)](https://zenodo.org/badge/latestdoi/344389637)




