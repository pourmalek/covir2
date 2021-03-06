## Variable name structure

Estimates of Daily Deaths, Total Deaths, Daily Cases, and Total Cases from component studies, are the target primary outcomes intended in the review. Incident daily event estimates are targeted for Total Deaths and Total Cases. 

In order to facilitate handling and preparation of the four outcome variables, naming of the variables from component studies was performed following some conventions described below. 

Variable names have 7 parts, each part denoting one piece of info about the variable, as described below through an example. 

<br/><br/>


#### --- Example variable name:

TotDeaMeRaA01S00V03

1234567890123456789


Tot...Dea...Me....Ra.....A01.....S00......V03

1-3...4-6...7-8...9-10...11-13...14-16....17-19


* 1-3 	Tot or Day: Total (cumulative) or Daily

* 4-6 	Dea or Cas: Deaths or Cases

* 7-8 	Me, Lo, or Up: Mean, Lower, Upper (uncertainty bound)

* 9-10 	Ra or Sm: Raw (not smoothed) or Smoothed

* 11-13 A00 to A05: Component study number (more details below)

* 14-16 S??: Scenario number within component study (more details below)

* 17-19	V??: Version of the model in component study (more details below)


Version of the model in component study is the only part that is fixed within each each component study in this review. 


The sample varaiable name TotDeaMeRaA01S00V03 denotes Total Deaths, mean raw, DELPHI, single scenario, version 3. 

<br/><br/>


#### * Component study number:

A00 JOHN Johns Hopkins

A01 DELP DELPHI (Differential Equations Leads to Predictions of Hospitalizations and Infections)

A02 IHME Institute for Health Metrics and Evaluation

A03 IMPE Imperial College

A04 LANL Los Alamos National Laboratory

A05 SRIV Srivastava

SOLT Soltani
	 
<br/><br/>


### References for component studies

* **A00 JOHN**
* Johns Hopkins University. Coronavirus resource center. https://coronavirus.jhu.edu/map.html
* **A01 DELP** 
* COVID Analytics. DELPHI epidemiological case predictions. Cambridge: Operations Research Center, Massachusetts Institute of Technology https://www.covidanalytics.io/projections
* **A02 IHME** 
* Institute for Health Metrics and Evaluation (IHME). COVID-19 mortality, infection, testing, hospital resource use, and social distancing projections. Seattle: Institute for Health Metrics and Evaluation (IHME), University of Washington. http://www.healthdata.org/covid
* **A03 IMPE** 
* MRC Centre for Global Infectious Disease Analysis (MRC GIDA). Future scenarios of the healthcare burden of COVID-19 in low- or middle-income countries. London: MRC Centre for Global Infectious Disease Analysis, Imperial College London. https://mrc-ide.github.io/global-lmic-reports
* **A04 LANL** 
* Los Alamos National Laboratory (LANL). COVID-19 cases and deaths forecasts. Los Alamos: Los Alamos National Laboratory (LANL). https://covid-19.bsvgateway.org
* **A05 SRIV**
University of Southern California (USC). COVID-19 forecast. Los Angeles: University of Southern California. https://scc-usc.github.io/ReCOVER-COVID-19
* **SOLT Soltani**
* Soltani K, Rezazadeh G. A New Dynamic Model to Predict the Effects of Governmental Decisions on the Progress of the CoViD-19 Epidemic. arxiv preprint. Submitted on 15 Aug 2020. https://arxiv.org/abs/2008.11716

<br/><br/>


### Scenario number within component study


[Names within brackets assigned by this review study.]

* **A00 JOHN**
* Not Applicable
* **A01 DELP** 
* S00 = Single scenario
* **A02 IHME** 
* S01 = Reference scenario [Status Quo] 
* S02 = Best scenario (Universal masks) [Best]
* S03 = Worse scenario (Mandates easing) [Worst] 
* **A03 IMPE** 
* S01 = Additional 50% Reduction [Best]	
* S02 = Maintain Status Quo	[Reference] 			
* S03  = Relax Interventions 50% [Worst]
* S04  Surged Additional 50% Reduction [Best, Surged]
* S05  "Surged Maintain Status Quo [Reference, Surged] 	
* S06  "Surged Relax Interventions 50% [Worst, Surged]	
* **A04 LANL** 
* S00 = Single scenario
* **A05 SRIV**
* S01 = [current1 = current level of interventions and reciprocal of gamma is 1 = current, worse]
* S02 = [current2 = current level of interventions and reciprocal of gamma is 2 = current, default]
* S03 = [current5 = current level of interventions and reciprocal of gamma is 5 = current, better]
* S04 = [current10 = current level of interventions and reciprocal of gamma is 10 (current extreme)]
* S05 = [current20 = current level of interventions and reciprocal of gamma is 20 (current extreme)]
* S06 = [current40 = current level of interventions and reciprocal of gamma is 40 (current extreme)]

* S07 = [released1 = released level of interventions and reciprocal of gamma is 1 = released, worse]
* S08 = [released2 = released level of interventions and reciprocal of gamma is 2 = released, default]
* S09 = [released5 = released level of interventions and reciprocal of gamma is 5 = released, better]
* S10 = [released10 = released level of interventions and reciprocal of gamma is 10 (released extreme)]
* S11 = [released20 = released level of interventions and reciprocal of gamma is 20 (released extreme)]
* S12 = [released40 = released level of interventions and reciprocal of gamma is 40 (too extreme)]

* S13 = [restricted1 = restricted level of interventions and reciprocal of gamma is 1 = restricted, worse]
* S14 = [restricted2 = restricted level of interventions and reciprocal of gamma is 2 = restricted, default]
* S15 = [restricted5 = restricted level of interventions and reciprocal of gamma is 5 = restricted, better]
* S16 = [restricted10 = restricted level of interventions and reciprocal of gamma is 10 (restricted extreme)]
* S17 = [restricted20 = restricted level of interventions and reciprocal of gamma is 20 (restricted extreme)]
* S18 = [restricted40 = restricted level of interventions and reciprocal of gamma is 40 (restricted extreme)
* **SOLT Soltani**
* S01 = Reopening scenario 1 = Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 35% and at lowest point between third and fourth peaks (about 2021-03-01 )is 20%. 
* S02 = Reopening scenario 2 = Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 32% and at lowest point between third and fourth peaks (about 2021-03-01 )is 22%.


<br/><br/>


### Version of the model in component study 

* A00 JOHN = Version Not Applicable

* A01 DELP = V03

* A02 IHME = V03

* A03 IMPE = V07	

* A04 LANL = V02

* A05 SRIV = Version Not Mentioned

* SOLT = Version Not Applicable


