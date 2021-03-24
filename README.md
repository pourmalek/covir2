# covir2

# COVID-19 Iran Review No 2, Stata codes

<br/><br/>


********************************************************************************************************************************************
* Project: Rapid review of estimates of COVID-19 Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time (initial): 2021-02-10
* **OBJECTIVE** of these Stata codes: Get and prepare component studies' estimates for Iran, locate peak dates and values, graph estimates
********************************************************************************************************************************************

<br/><br/>


* Details: This is a review study of estimates of COVID-19 in Iran for time period December 2020 onwards. The codes in this repository get the estimations performed by the component studies, prepare them, locate peak dates and values, and produce graphs using Stata. This repo can be used to replicate the results of the review study ('Computational reproducibility').

<br/><br/>



### SUMMARY of how to use the codes in this repo

1. Go to repo home page covir2 / Data / [master page](https://github.com/pourmalek/covir2)

2. Click on `Code`, then `Download ZIP` to your local machine

3. Locate the DOWNLODED "covir2-main" directory on your local machine, in the Downloads folder

4. Locate file *"do Iran master.do"* in your local directory |Downloads|covir2-main|Data|master| and run this do file. This "do Iran master.do" initiates all other codes. | denotes / for Mac or \ for Windows.

- Once all the codes have run, the final outputs would show up: "log Iran merge.smcl", and the last graph. This signifies the end of the code implementation. Graph files are stored in your local system's directory Downloads/covir2-main/Data/merge/ (Mac) or Downloads\covir2-main\Data\merge\ (Windows).

5. Go to your local directory |Downloads|covir2-main|Data|merge|. Files "Iran.dta" and "Iran.csv" contain all the combibed data. The combined graphs are stored in this directory. 

6. If Stata returns error codes, check the [troubleshooting](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

<br/><br/>

* Details of do files:

Stata do files get and prepare component studies' estimates for Iran, using the component studies' web pages that contain their estimates’ files - studies "Soltani" and "Ghanbari" graphs digitized. The file "do Iran master.do" is the only file that needs to be run. 

<br/><br/>


* Directory structure:

Do files are located in directories: 

covir2 / data / [DELP](https://github.com/pourmalek/covir2/tree/main/Data/DELP), [GHAN](https://github.com/pourmalek/covir2/tree/main/Data/GHAN), [IHME](https://github.com/pourmalek/covir2/tree/main/Data/IHME), [IMPE](https://github.com/pourmalek/covir2/tree/main/Data/IMPE), [JOHN](https://github.com/pourmalek/covir2/tree/main/Data/JOHN), [LANL](https://github.com/pourmalek/covir2/tree/main/Data/LANL), [SOLT](https://github.com/pourmalek/covir2/tree/main/Data/Soltani), [SRIV](https://github.com/pourmalek/covir2/tree/main/Data/SRIV), [master](https://github.com/pourmalek/covir2/tree/main/Data/master), [merge](https://github.com/pourmalek/covir2/tree/main/Data/merge)

<br/><br/>


* **List of descriptive texts in other md files in this repo**

* For description of variable name structure used in codes, see covir2 / [Variable name structure](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.md)

* For troubleshooting possible errors returned during running the codes, see covir2 / [troubleshooting](https://github.com/pourmalek/covir2/blob/main/Troubleshooting.md)

<br/><br/>

### Related repositories 
* [`covir2`](https://github.com/pourmalek/covir2), the current repo, is the main repo, related to which are the following:

* [`covir2-output`](https://github.com/pourmalek/covir2-output) contains a copy of previously created #### **outputs**

* [`covir2-updates`](https://github.com/pourmalek/covir2-updates) contains periodical UPDATES for *codes*

* [`covir2-output-updates`](https://github.com/pourmalek/covir2-output-updates) contains periodical UPDATES for *outputs*

<br/><br/>

* See [LICENSE](https://github.com/pourmalek/covir2/blob/main/LICENSE)

<br/><br/>

[![DOI](https://zenodo.org/badge/344389637.svg)](https://zenodo.org/badge/latestdoi/344389637)




