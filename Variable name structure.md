## Variable name structure

Estimates of Daily Deaths, Total Deaths, Daily Cases, and Total Cases from component studies, are the target primary outcomes intended in the review. Incident (not prevalent) daily cases estimates are targeted, where avialable, for Daily Cases. 

In order to facilitate data management, the four target outcome variables were `rename`d using the variables from component studies according to following conventions. Primary variable names have 7 parts, each part denoting one piece of info about the variable, as described below through an example. Secondary variable names have one additional compmonent.

Primary variables were created by the component studies, their `var name`s and `var label`s were modified in this review study codes. Secondary variables were created in this review study codes, to store certain values of daily primary variables, as described further below. 

All the variables have descriptive var `label`s that show what the variable stores. 


<br/><br/>


#### Primary variable names:

Example:

TotDeaMeRaA01S00V03

1234567890123456789


Tot...Dea...Me....Ra.....A01.....S00......V03

1-3...4-6...7-8...9-10...11-13...14-16..17-19
<br/><br/>

* 1-3 	Tot or Day: Total (cumulative) or Daily (incident daily for cases)

* 4-6 	Dea or Cas: Deaths or Cases

* 7-8 	Me, Lo, or Up: Mean, Lower, Upper (uncertainty bound)

* 9-10 	Ra or Sm: Raw (not smoothed) or Smoothed

* 11-13 A00 to A05: Component study number (more details below)

* 14-16 S??: Scenario number within component study (more details below)

* 17-19	V??: Version of the model in component study (more details below)


Version of the model in component study is the only part that is fixed within each component study in this review. 


The example primary variable name, TotDeaMeRaA01S00V03, denotes Total Deaths, mean, raw, DELPHI, single scenario, version 3. 

<br/><br/>

#### Secondary variable names:

Values and dates of peaks (or other time points) of daily deaths and daily cases are stored in secondary variables, ending in the following three characters: P?? 

* 20-22	P??:

* 20 P: Peak (or other time point) 

* 21 ?: Number of peak (or other time point). 0: One peak (only one peak shown), 1: Peak 1, 2: Peak 2, 3: Peak 3, 4: Peak 4, 5: Start of plateau after peak three (in JOHN), 6: Start of increase after peak three (in JOHN), 7: Start time (of provided estimates), 8: End time (of provided estimates)

* 22 V or D: Value or Date (of estimate)


Example:

In DayDeaMeRaA01S00V03P0D, P0D denotes "One peak, Date", and the whole variable name DayDeaMeRaA01S00V03P0D denotes Date of one peak shown in DayDeaMeRaA01S00V03. 

Example:

In DayDeaMeRaA01S00V03P0V, P0V denotes "One peak, Value", and the whole variable name DayDeaMeRaA01S00V03P0V denotes Value of one peak shown in DayDeaMeRaA01S00V03.

<br/><br/>


#### * Component study number:
<br/><br/>

A00 JOHN Johns Hopkins

A01 DELP DELPHI (Differential Equations Leads to Predictions of Hospitalizations and Infections)

A02 IHME Institute for Health Metrics and Evaluation

A03 IMPE Imperial College

A04 LANL Los Alamos National Laboratory

A05 SRIV Srivastava

A06 SOLT Soltani

A07 GHAN Ghanbari
	 
<br/><br/>


### References for component studies
<br/><br/>

**A00 JOHN**
Johns Hopkins University. Coronavirus resource center. https://coronavirus.jhu.edu/map.html
<br/><br/>
**A01 DELP** 
COVID Analytics. DELPHI epidemiological case predictions. Cambridge: Operations Research Center, Massachusetts Institute of Technology https://www.covidanalytics.io/projections
<br/><br/>
**A02 IHME** 
Institute for Health Metrics and Evaluation (IHME). COVID-19 mortality, infection, testing, hospital resource use, and social distancing projections. Seattle: Institute for Health Metrics and Evaluation (IHME), University of Washington. http://www.healthdata.org/covid
<br/><br/>
**A03 IMPE** 
MRC Centre for Global Infectious Disease Analysis (MRC GIDA). Future scenarios of the healthcare burden of COVID-19 in low- or middle-income countries. London: MRC Centre for Global Infectious Disease Analysis, Imperial College London. https://mrc-ide.github.io/global-lmic-reports
<br/><br/>
**A04 LANL** 
Los Alamos National Laboratory (LANL). COVID-19 cases and deaths forecasts. Los Alamos: Los Alamos National Laboratory (LANL). https://covid-19.bsvgateway.org
<br/><br/>
**A05 SRIV**
University of Southern California (USC). COVID-19 forecast. Los Angeles: University of Southern California. https://scc-usc.github.io/ReCOVER-COVID-19
<br/><br/>
**A06 SOLT**
Soltani K, Rezazadeh G. A New Dynamic Model to Predict the Effects of Governmental Decisions on the Progress of the CoViD-19 Epidemic. arxiv preprint. Submitted on 15 Aug 2020. https://arxiv.org/abs/2008.11716
<br/><br/>
**A07 GHAN**
Ghanbari B. On forecasting the spread of the COVID-19 in Iran: The second wave. Chaos Solitons Fractals. 2020 Nov;140:110176. doi: 10.1016/j.chaos.2020.110176. Epub 2020 Jul 28. [https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7386426/](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7386426/)
<br/><br/>

### Scenario number within component study
<br/><br/>

[Names within brackets assigned by this review study.]

* **A00 JOHN**
* Not Applicable
<br/><br/>
* **A01 DELP** 
* S00 = [Single scenario]
<br/><br/>
* **A02 IHME** 
* S01 = Reference scenario [Status Quo] 
* S02 = Best scenario (Universal masks) [Best]
* S03 = Worse scenario (Mandates easing) [Worst] 
<br/><br/>
* **A03 IMPE** 
* S01 = Additional 50% Reduction [Best]	
* S02 = Current level of interventions [Reference] 			
* S03 = Relax Interventions 50% [Worst]
* S04 = Surged Additional 50% Reduction [Best, Surged]
* S05 = Surged Maintain Status Quo [Reference, Surged] 	
* S06 = Surged Relax Interventions 50% [Worst, Surged]	
<br/><br/>
* **A04 LANL** 
* S00 = [Single scenario]
<br/><br/>
* **A05 SRIV**
* S01 = [current1 = current level of interventions and reciprocal of gamma is 1 = current, worse]
* S02 = [current2 = current level of interventions and reciprocal of gamma is 2 = current, default]
* S03 = [current5 = current level of interventions and reciprocal of gamma is 5 = current, better]
* S04 = [current10 = current level of interventions and reciprocal of gamma is 10 (current extreme)]
* S05 = [current20 = current level of interventions and reciprocal of gamma is 20 (current extreme)]
* S06 = [current40 = current level of interventions and reciprocal of gamma is 40 (current extreme)]
<br/><br/>
* S07 = [released1 = released level of interventions and reciprocal of gamma is 1 = released, worse]
* S08 = [released2 = released level of interventions and reciprocal of gamma is 2 = released, default]
* S09 = [released5 = released level of interventions and reciprocal of gamma is 5 = released, better]
* S10 = [released10 = released level of interventions and reciprocal of gamma is 10 (released extreme)]
* S11 = [released20 = released level of interventions and reciprocal of gamma is 20 (released extreme)]
* S12 = [released40 = released level of interventions and reciprocal of gamma is 40 (released extreme)]
<br/><br/>
* S13 = [restricted1 = restricted level of interventions and reciprocal of gamma is 1 = restricted, worse]
* S14 = [restricted2 = restricted level of interventions and reciprocal of gamma is 2 = restricted, default]
* S15 = [restricted5 = restricted level of interventions and reciprocal of gamma is 5 = restricted, better]
* S16 = [restricted10 = restricted level of interventions and reciprocal of gamma is 10 (restricted extreme)]
* S17 = [restricted20 = restricted level of interventions and reciprocal of gamma is 20 (restricted extreme)]
* S18 = [restricted40 = restricted level of interventions and reciprocal of gamma is 40 (restricted extreme)
<br/><br/>
* **SOLT Soltani**
* S01 = Reopening scenario 1 = Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 35% and at lowest point between third and fourth peaks (about 2021-03-01 )is 20%. 
* S02 = Reopening scenario 2 = Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 32% and at lowest point between third and fourth peaks (about 2021-03-01 )is 22%.
<br/><br/>
* **GHAN Ghanbari**
* Ghanbari has two subtypes of Daily Cases, “Density of the infected population with a strong immunity system”, 
and “Density of the infected population with a weak immunity system or with a historical medical illness as diabetic, blood pressure, heart issue, and others. [*verbatim*]” Each subtype is presented with 18 different values (aka model subtypes) based on different values of three parameters in their model. 
We selected the median scenario for the first subtype for digitalization. It is model the model subtype number 9 out of 18 subtypes (named S09 here), with the following details. Model subtype parameter: γ1 = 0.09, where γ1 is recovery rate in population subtype 1. 
Time point: Second peak. 
Estimate type: Mean. 
Peak value mentioned: 897,264. 
Peak date Solar: 1399 11 30. 
Peak date Gregorian: 2021 02 18. 	
Source: Fig 4a, green curve. 


<br/><br/>


### Version of the model in component study 
<br/><br/>

* A00 JOHN = V00 (Version Not Applicable)

* A01 DELP = V03

* A02 IHME = V03

* A03 IMPE = V07	

* A04 LANL = V02

* A05 SRIV = V00 (Version Not Mentioned, aka not readily locatable)

* A06 SOLT = V00 (Version Not Applicable)

* A07 GHAN = V00 (Version Not Applicable)




