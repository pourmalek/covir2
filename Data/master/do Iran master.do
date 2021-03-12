
/* Edit the contents within " " of the line:
global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/Data/" [for Mac]
global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\Data\" [for Windows]
below - if needed - to reflect where the directory /data/ or \data\ is located on your machine.
This code was developed and run using Stata SE 14.2 on MacOS Big Sur 11.2.2 (also ran on same flavour of Stata on Windows 10)
*/



* setup Stata path by operating system 

set more off 

set mem 1000m // for older versions of Stata

clear all

dis "`c(username)'"

local usrnam = "`c(username)'"

di "`usrnam'"

* set path based on local operating system 

if regexm(c(os),"Mac") == 1 {
	global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/Data/" 
}
else if regexm(c(os),"Windows") {
	global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\Data\"
}
*


cd "$pathcovir2"
 
cd master

***************************************************************************
* This is "do Iran master.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare component studies' estimates for Iran, Locate peak dates and values
***************************************************************************



* presrve native scheme (of the local machine; will be eventually restored at the end of "do Iran merge.do")

di c(scheme)

global nativescheme `c(scheme)'

di "$nativescheme"



* get grstyle for graphs and its dependencies

ssc install grstyle, replace
ssc install palettes, replace
ssc install colrspace, replace

grstyle init
set scheme _GRSTYLE_ 
grstyle color background white




/* 

List of component studies:
JOHN
DELP
IHME
IMPE
LANL
SRIV
SOLT
GHAN

*/




* run the do files for each study and merge them. 

* IF the target server for a given study is temp down, comment out that line. 


do "$pathcovir2/JOHN/do Iran JOHN.do" 

do "$pathcovir2/DELP/do Iran DELP.do" 

do "$pathcovir2/IHME/do Iran IHME.do" 

do "$pathcovir2/IMPE/do Iran IMPE.do" 

do "$pathcovir2/LANL/do Iran LANL.do" 

do "$pathcovir2/SRIV/do Iran SRIV.do" 

do "$pathcovir2/SOLT/do Iran SOLT.do" 

do "$pathcovir2/GHAN/do Iran GHAN.do" 


do "$pathcovir2/merge/do Iran merge.do" 




* Useful additional note 1:  If Adobe Acrobat Professional is available on your local machine, the commented-out commands -// // graph export ...- can be de-comment-outed. 

* Useful additional note 2:  After first clean execution of entire codes, time-consuming commands can be /* bypassed */. These are -copy- commands to downloaded component studies' estimates files, and -import delimited- after them. 









/*

Documentation:


***********************
Variable name structure
***********************

Estimates of Daily Deaths, Total Deaths, Daily Cases, and Total Cases from component studies, are the target primary outcomes intended in the review. Incident (not prevalent) daily cases estimates are targeted, where available, for Daily Cases.
In order to facilitate data management, the four target outcome variables were renamed using the variables from component studies according to following conventions. Primary variable names have 7 parts, each part denoting one piece of info about the variable, as described below through an example. Secondary variable names have one additional component.
Primary variables were created by the component studies, their var names and var labels were modified in this review study codes. Secondary variables were created in this review study codes, to store certain values of daily primary variables, as described further below.
All the variables have descriptive var labels that show what the variable stores.


Primary variable names:

Example:
TotDeaMeRaA01S00V03
1234567890123456789
Tot...Dea...Me....Ra.....A01.....S00......V03
1-3...4-6...7-8...9-10...11-13...14-16..17-19 

•	1-3 Tot or Day: Total (cumulative) or Daily (incident daily for cases)
•	4-6 Dea or Cas: Deaths or Cases
•	7-8 Me, Lo, or Up: Mean, Lower, Upper (uncertainty bound)
•	9-10 Ra or Sm: Raw (not smoothed) or Smoothed
•	11-13 A00 to A05: Component study number (more details below)
•	14-16 S??: Scenario number within component study (more details below)
•	17-19 V??: Version of the model in component study (more details below)
Version of the model in component study is the only part that is fixed within each component study in this review.
The example primary variable name, TotDeaMeRaA01S00V03, denotes Total Deaths, mean, raw, DELPHI, single scenario, version 3.


Secondary variable names:

Values and dates of peaks (or other time points) of daily deaths and daily cases are stored in secondary variables, ending in the following three characters: P??
•	20-22 P??:
•	20 P: Peak (or other time point)
•	21 ?: Number of peak (or other time point). 0: One peak (only one peak shown), 1: Peak 1, 2: Peak 2, 3: Peak 3, 4: Peak 4, 5: Start of plateau after peak three (in JOHN), 6: Start of increase after peak three (in JOHN), 7: Start time (of provided estimates), 8: End time (of provided estimates)
•	22 V or D: Value or Date (of estimate)
Example:
In DayDeaMeRaA01S00V03P0D, P0D denotes "One peak, Date", and the whole variable name DayDeaMeRaA01S00V03P0D denotes Date of one peak shown in DayDeaMeRaA01S00V03.
Example:
In DayDeaMeRaA01S00V03P0V, P0V denotes "One peak, Value", and the whole variable name DayDeaMeRaA01S00V03P0V denotes Value of one peak shown in DayDeaMeRaA01S00V03.


* Component study number:


A00 JOHN Johns Hopkins
A01 DELP DELPHI (Differential Equations Leads to Predictions of Hospitalizations and Infections)
A02 IHME Institute for Health Metrics and Evaluation
A03 IMPE Imperial College
A04 LANL Los Alamos National Laboratory
A05 SRIV Srivastava
A06 SOLT Soltani
A07 GHAN Ghanbari


********************************
References for component studies
********************************


A00 JOHN Johns Hopkins University. Coronavirus resource center. https://coronavirus.jhu.edu/map.html 

A01 DELP COVID Analytics. DELPHI epidemiological case predictions. Cambridge: Operations Research Center, Massachusetts Institute of Technology https://www.covidanalytics.io/projections 

A02 IHME Institute for Health Metrics and Evaluation (IHME). COVID-19 mortality, infection, testing, hospital resource use, and social distancing projections. Seattle: Institute for Health Metrics and Evaluation (IHME), University of Washington. http://www.healthdata.org/covid 

A03 IMPE MRC Centre for Global Infectious Disease Analysis (MRC GIDA). Future scenarios of the healthcare burden of COVID-19 in low- or middle-income countries. London: MRC Centre for Global Infectious Disease Analysis, Imperial College London. https://mrc-ide.github.io/global-lmic-reports 

A04 LANL Los Alamos National Laboratory (LANL). COVID-19 cases and deaths forecasts. Los Alamos: Los Alamos National Laboratory (LANL). https://covid-19.bsvgateway.org 

A05 SRIV University of Southern California (USC). COVID-19 forecast. Los Angeles: University of Southern California. https://scc-usc.github.io/ReCOVER-COVID-19 

A06 SOLT Soltani K, Rezazadeh G. A New Dynamic Model to Predict the Effects of Governmental Decisions on the Progress of the CoViD-19 Epidemic. arxiv preprint. Submitted on 15 Aug 2020. https://arxiv.org/abs/2008.11716 

A07 GHAN Ghanbari B. On forecasting the spread of the COVID-19 in Iran: The second wave. Chaos Solitons Fractals. 2020 Nov;140:110176. doi: 10.1016/j.chaos.2020.110176. Epub 2020 Jul 28. https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7386426/ 

Scenario number within component study


[Names within brackets assigned by this review study.]
•	A00 JOHN
•	S00 = [Not Applicable] 

•	A01 DELP
•	S00 = [Single scenario] 

•	A02 IHME
•	S01 = Reference scenario [Status Quo]
•	S02 = Best scenario (Universal masks) [Best]
•	S03 = Worse scenario (Mandates easing) [Worst] 

•	A03 IMPE
•	S01 = Additional 50% Reduction [Best]
•	S02 = Current level of interventions [Reference]
•	S03 = Relax Interventions 50% [Worst]
•	S04 = Surged Additional 50% Reduction [Best, Surged]
•	S05 = Surged Maintain Status Quo [Reference, Surged]
•	S06 = Surged Relax Interventions 50% [Worst, Surged] 

•	A04 LANL
•	S00 = [Single scenario] 

•	A05 SRIV
•	S01 = [current1 = current level of interventions and reciprocal of gamma is 1 = current, worse]
•	S02 = [current2 = current level of interventions and reciprocal of gamma is 2 = current, default]
•	S03 = [current5 = current level of interventions and reciprocal of gamma is 5 = current, better]
•	S04 = [current10 = current level of interventions and reciprocal of gamma is 10 (current extreme)]
•	S05 = [current20 = current level of interventions and reciprocal of gamma is 20 (current extreme)]
•	S06 = [current40 = current level of interventions and reciprocal of gamma is 40 (current extreme)] 

•	S07 = [released1 = released level of interventions and reciprocal of gamma is 1 = released, worse]
•	S08 = [released2 = released level of interventions and reciprocal of gamma is 2 = released, default]
•	S09 = [released5 = released level of interventions and reciprocal of gamma is 5 = released, better]
•	S10 = [released10 = released level of interventions and reciprocal of gamma is 10 (released extreme)]
•	S11 = [released20 = released level of interventions and reciprocal of gamma is 20 (released extreme)]
•	S12 = [released40 = released level of interventions and reciprocal of gamma is 40 (released extreme)] 

•	S13 = [restricted1 = restricted level of interventions and reciprocal of gamma is 1 = restricted, worse]
•	S14 = [restricted2 = restricted level of interventions and reciprocal of gamma is 2 = restricted, default]
•	S15 = [restricted5 = restricted level of interventions and reciprocal of gamma is 5 = restricted, better]
•	S16 = [restricted10 = restricted level of interventions and reciprocal of gamma is 10 (restricted extreme)]
•	S17 = [restricted20 = restricted level of interventions and reciprocal of gamma is 20 (restricted extreme)]
•	S18 = [restricted40 = restricted level of interventions and reciprocal of gamma is 40 (restricted extreme) 

•	SOLT Soltani
•	S01 = Reopening scenario 1 = [Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 35% and at lowest point between third and fourth peaks (about 2021-03-01 )is 20%].
•	S02 = Reopening scenario 2 = [Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 32% and at lowest point between third and fourth peaks (about 2021-03-01 )is 22%]. 

•	GHAN Ghanbari
•	Ghanbari has two subtypes of Daily Cases, “Density of the infected population with a strong immunity system”, and “Density of the infected population with a weak immunity system or with a historical medical illness as diabetic, blood pressure, heart issue, and others. [verbatim]” Each subtype is presented with 18 different values (aka model subtypes) based on different values of three parameters in their model. We selected the median scenario for the first subtype for digitalization. It is model the model subtype number 9 out of 18 subtypes [named S09 here], with the following details. Model subtype parameter: γ1 = 0.09, where γ1 is recovery rate in population subtype 1. Time point: Second peak. Estimate type: Mean. Peak value mentioned: 897,264. Peak date Solar: 1399 11 30. Peak date Gregorian: 2021 02 18. Source: Fig 4a, green curve.



***************************************
Version of the model in component study
***************************************

•	A00 JOHN = V00 [Version Not Applicable; updates daily]
•	A01 DELP = V03
•	A02 IHME = V03
•	A03 IMPE = V07
•	A04 LANL = V02
•	A05 SRIV = V00 [Version Not Mentioned; or could not be located]
•	A06 SOLT = V00 [Version Not Applicable; non-updating study]
•	A07 GHAN = V00 [Version Not Applicable, non-updating study]


Note: Johns Hopkins, obviously not an "estimation study", is used as a benchmark gauge of the under-reported so-called "Ground Truth".

*/


