
/* Edit the contents within " " of the line:

global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/Data/" [for Mac]

global pathcovir2 = "C:\Users\`usrnam'\Downloads\covir2-main\Data\" [for Windows]

below - if needed - to reflect where the directory /data/ or \data\ is located on your machine.


This code was developed and run using Stata SE 14.2 on MacOS Big Sur 11.2.2

*/



* setup Stata path by operating system 

set more off 

clear all

dis "`c(username)'"

local usrnam = "`c(username)'"

di "`usrnam'"


if regexm(c(os),"Mac") == 1 {
	global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/Data/" 
}
else if regexm(c(os),"Windows") == 1 global pathcovir2 = "C:\Users\`usrnam'\Downloads\covir2-main\Data\"


cd "$pathcovir2"

cd master

***************************************************************************
* This is "do Iran master.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare component studies' estimates for Iran, Locate peak dates and values
***************************************************************************


/* 

Component studies:

JOHN
DELP
IHME
IMPE
LANL
SRIV
Ghanbari
Soltani
*/



* run the do files for each study and merge them

local dolist JOHN DELP IHME IMPE LANL SRIV Soltani merge

foreach do in `dolist' {

	do "$pathcovir2/`do'/do Iran `do'.do" 

}
* 



/*

References for component studies

A00 JOHN
Johns Hopkins University. Coronavirus resource center. https://coronavirus.jhu.edu/map.html

A01 DELP
COVID Analytics. DELPHI epidemiological case predictions. Cambridge: Operations Research Center, Massachusetts Institute of Technology https://www.covidanalytics.io/projections

A02 IHME
Institute for Health Metrics and Evaluation (IHME). COVID-19 mortality, infection, testing, hospital resource use, and social distancing projections. Seattle: Institute for Health Metrics and Evaluation (IHME), University of Washington. http://www.healthdata.org/covid

A03 IMPE
MRC Centre for Global Infectious Disease Analysis (MRC GIDA). Future scenarios of the healthcare burden of COVID-19 in low- or middle-income countries. London: MRC Centre for Global Infectious Disease Analysis, Imperial College London. https://mrc-ide.github.io/global-lmic-reports

A04 LANL
Los Alamos National Laboratory (LANL). COVID-19 cases and deaths forecasts. Los Alamos: Los Alamos National Laboratory (LANL). https://covid-19.bsvgateway.org

A05 SRIV University of Southern California (USC). COVID-19 forecast. Los Angeles: University of Southern California. https://scc-usc.github.io/ReCOVER-COVID-19

SOLT Soltani
Soltani K, Rezazadeh G. A New Dynamic Model to Predict the Effects of Governmental Decisions on the Progress of the CoViD-19 Epidemic. arxiv preprint. Submitted on 15 Aug 2020. https://arxiv.org/abs/2008.11716
*/




