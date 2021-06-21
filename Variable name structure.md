## Variable name structure :book:

### A common template for editing models’ output data

Estimates of (1) Daily Deaths, (2) Total Deaths, (3) Daily Cases (incident or prevalent), and (4) Total Cases (incident) from component studies, are the primary outcome variables of interest in this review. Hospital-related and other outcomes from component studies are the secondary outcome variables.

Primary variables were taken from component studies. Secondary variables were calculated in this review. In order to facilitate data management, the primary variables were `-rename-`d or `-renvar-`ed using the variables from component studies according to following conventions. The same set of conventions were adhered to in naming all outcome variables. 

As described below through an example, primary variable names have 7 parts, each part denoting one piece of info about the variable. 

All the variables have descriptive var `-label-`s that show what the variable stores. 

`Stata` commands are displayed as `-command-` and `Stata` non-command syntax as -syntax-.
<br/><br/>

***********************

### Variable names

## NOTE: (1) Starting from re-run on 20210519 of uptake 20210515, including model version in variable names and labels is retired. 

## NOTE: (2) Retirement of inclusion of model version in variable names and labels is being also extended to previous uptakes, starting from uptake 20210401. 


<br/><br/>
#### Primary outcome variable names:


Example:

TotDeaMeRaA01S00V03

1234567890123456789

-varname- has 19 positions. 


Tot...Dea...Me....Ra.....A01.....S00......V03

1-3...4-6...7-8...9-10...11-13...14-16..17-19
<br/><br/>

* Positions 1-3: Tot or Day: Total (cumulative) or Daily 

* Positions 4-6: Dea, Cas, or Act: Dea for Deaths, Cas for incident Cases, or Act for Active cases (for primary outcomes; for secondary outcomes see below)

* Positions 7-8: Me, Lo, or Up: Mean, Lower, or Upper (uncertainty bound)

* Positions 9-10: Ra or Sm: Raw (not smoothed) or Smoothed

* Positions 11-13: A00 to A05: Component study number (see details below)

* Positions 14-16 S??: Scenario number within component study (see details below)

* Positions 17-19: V??: Version of the model in component study (see details below)


Version of the model in component study is the only part that is fixed within each component study in this review, within each update. That is not the case within [`longitudinal`](https://github.com/pourmalek/covir2/tree/main/longitudinal) assessment. 


The example primary variable name, TotDeaMeRaA01S00V03, denotes Total Deaths, mean, raw, DELPHI, single scenario, model version 3. 

<br/><br/>

***********************

#### Secondary outcome variable names:

* Positions 4-6 in variable name can be, for instance,  *Act*, that means *Active cases* [in study *DELP*]

* Positions 4-6: meaning [study]

* Act: Active cases [DELP]									
* Adm: Admissions (hospital admissions by day) [IHME]				
* Bed: Bed need (covid beds needed by day) [IHME]					
* Beo: Bed over ( [covid all beds needed] - ([total bed capacity] - [average all bed usage]) ) [IHME]
* Cax: Cases AVERTED [CSIM]
* CaY: Cases COUNTERFACTUAL [CSIM]
* DeY: Deaths COUNTERFACTUAL [CSIM]
* DeZ: Deaths REPORTED [CSIM] 
* Hod: Hospital Demand [IMPE]									
* Hos: Hospitalized [DELP], Hospitalisations [CSIM]										
* Hoi: Hospital incidence [IMPE]									
* Icd: ICU Demand [IMPE]										
* Ici: ICU incidence [IMPE], Critical care  [CSIM]								
* Icn: ICU new (number of new people going to the ICU by day) [IHME]		
* Ico: ICU over ( [covid ICU beds needed] - ([total ICU capacity] - [average ICU bed usage]) ) [IHME]
* Icu: ICU need (ICU covid beds needed by day) [IHME]					
* Pre: Prevalence [IMPE]										
* Ref: R effective [IMPE]										
* Rtt : R t [IMPE]											
* Ser: Seroprevalence (seroprevalence) [IHME]						
* Tes: Tests (total tests) [IHME]		
* Vax: Fully vaccinated persons [CSIM]					
* Ven: Ventilated [DELP]									
* Ven: Vent need (invasive Ventilation needed by day) [IHME]


Example: The -varname- DayIcdMeRaA03S01V07 carries -varlabel- "Daily ICU demand Mean A03 S01 V07". It is the daily ICU demand, mean estimate, in study A03 (IMPE), scenario 1, model version 7. 

Variable names and short description for hospital-related outcomes by IHME, are mentioned in "IHME_COVID_19_Data_Release_Information_Sheet.pdf" released with each estimates update of IHME. These Data_Release_Information_Sheet files are stored in covir2 repository in "covir2/202YMMDD/output/IHME/202Y_MM_DD/ IHME_COVID_19_Data_Release_Information_Sheet.pdf", where "202YMMDD" is the uptake date by covir2 and "202Y_MM_DD" is the update directory name created by downloading the zip file of IHME estimates update. [Example](https://github.com/pourmalek/covir2/blob/main/20210401/output/IHME/2021_04_01/IHME_COVID_19_Data_Release_Information_Sheet.pdf) for IHME update 20210401 in [covir2/20210401/output/IHME/2021_04_01/](https://github.com/pourmalek/covir2/tree/main/20210401/output/IHME/2021_04_01)



<br/><br/>
			
***********************

#### Secondary variable names:

Secondary variables have 2 subtypes: (1) store a calculated daily CFR, (1) store values created for visualization of temporal succession of daily cases and daily deaths peaks.


_(1) store a calculated daily CFR_

* Positions 4-6 read as CFR. 

Example:

DayCfrMeRaA00S00V00 "Daily CFR JOHN"


_(2) store values created for visualization of temporal succession of daily cases and daily deaths peaks_

* CaM: (Cases Mean) Daily Cases Mean (within each country in EMR) [JOHNEMR]
* CbD (Cases by Deaths) "Daily cases mean div by daily deaths mean JOHN" [JOHNEMR]
* DeM: (Deaths Mean) Daily Deaths Mean (within each country in EMR) [JOHNEMR]

* DayDea_multip_ "Daily deaths scaled (times means of cases by deaths) only for visualization JOHN" [JOHNEMR] This one is a deviation from the overarching nomenclature rules. 


<br/><br/>

***********************

#### Component study number:


A00 JOHN Johns Hopkins

A01 DELP DELPHI (Differential Equations Leads to Predictions of Hospitalizations and Infections)

A02 IHME Institute for Health Metrics and Evaluation

A03 IMPE Imperial College

A04 LANL Los Alamos National Laboratory

A05 SRIV Srivastava

A06 SOLT Soltani

A07 GHAN Ghanbari
	 
A08 YYGU Youyang Gu (was included in a 20210423 uptake; this uptake was later omitted in conformation to the [rule for creating uptakes](https://github.com/pourmalek/covir2/tree/main/setup))
<br/><br/>

(Additional international studies’ number starting from 16, to represent 6th international study and onwards.)

A16 CSIM COVID-19 Simulation

A17 UCLA University of California, Los Angeles


***********************

### References for component studies


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
YYGU [study web site](https://covid19-projections.com)
<br/><br/>


**A17 UCLA**
Zou D, Wang L, Xu P, Chen J, Zhang W, Gu Q. Epidemic Model Guided Machine Learning for
COVID-19 Forecasts in the United States. medRxiv per-print. Posted May 25, 2020. doi: https://doi.org/10.1101/2020.05.24.20111989 https://www.medrxiv.org/content/10.1101/2020.05.24.20111989v1

<br/><br/>

***********************

### Scenario number within component study

[Names within brackets assigned by this review study.]

* **A00 JOHN**
* S00 = [Not Applicable]
<br/><br/>
* **A01 DELP** 
* S00 = [Single scenario]
<br/><br/>
* **A02 IHME**       **(see more details below)**
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
* S00 = [current]
<br/><br/>
* **SOLT Soltani**
* S01 = Reopening scenario 1 = [Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 35% and at lowest point between third and fourth peaks (about 2021-03-01) is 20%]. 
* S02 = Reopening scenario 2 = [Percentage of population "free from quarantine" upon reopening at lowest point between second and third peaks (about 2020-09-01) is 32% and at lowest point between third and fourth peaks (about 2021-03-01) is 22%].
<br/><br/>
* **GHAN Ghanbari**
* Ghanbari has two subtypes of Daily Cases, “Density of the infected population with a strong immunity system”, and “Density of the infected population with a weak immunity system or with a historical medical illness as diabetic, blood pressure, heart issue, and others.” [*verbatim*] Each subtype is presented with 18 different values (aka model subtypes) based on different values of three parameters in their model. The median scenario, first subtype was selected for digitalization. It is the model subtype number 9 out of 18 subtypes [named S09 here], with the following details. Model subtype parameter: γ1 = 0.09, where γ1 is recovery rate in population subtype 1. Time point: Second peak. Estimate type: Mean. Peak value mentioned: 897,264. Peak date Solar: 1399-11-30. Peak date Gregorian: 2021-02-18. Source: Fig 4a, green curve. 


* **A17 UCLA** 
* S00 = [Single scenario]

<br/><br/>

**Details about IHME scenarios:**

[IHME. COVID-19 Results Briefing, The Eastern Mediterranean Region. May 13, 2021. Page 19, Projections and scenarios]( http://www.healthdata.org/sites/default/files/files/Projects/COVID/2021/44567_briefing_Eastern_Mediterranean_Region_16.pdf) “The model was run on May 12, 2021.”

(S1) The reference scenario is our forecast of what we think is most likely to happen: 

1- Vaccines are distributed at the expected pace. 

2- Governments adapt their response by re-imposing social distancing mandates for 6 weeks whenever daily deaths reach 8 per million, unless a location has already spent at least 7 of the last 14 days with daily deaths above this rate and not yet re-imposed social distancing mandates. In this case, the scenario assumes that mandates are re-imposed when daily deaths reach 15 per million. 

3- Variants B.1.1.7 (first identified in the UK), B.1.351 (first identified in South Africa), and P1 (first identified in Brazil) continue to spread from locations with (a) more than 5 sequenced variants, and (b) reports of community transmission, to adjacent locations following the speed of variant scale-up observed in the regions of the UK.

4- In one-quarter of those vaccinated, mobility increases toward pre-COVID-19 levels.

(S2) The universal masks scenario makes all the same assumptions as the reference scenario but also assumes 95% of the population wear masks in public in every location. 

(S3) The worse scenario modifies the reference scenario assumptions in three ways: 

1- First, it assumes that variants B.1.351 or P1 begin to spread within 3 weeks in adjacent locations that do not already have B.1.351 or P1 community transmission. 

2- Second, it assumes that all those vaccinated increase their mobility toward pre-COVID-19 levels. 

3- Third, it assumes that among those vaccinated, mask use starts to decline exponentially one month after completed vaccination. 



<br/><br/>

***********************

### Version of the model in component studies


* A00 JOHN = V00 [Version Not Applicable; updates daily]

* A06 SOLT = V00 [Version Not Applicable; non-updating study]

* A07 GHAN = V00 [Version Not Applicable, non-updating study]

<br/><br/>
Note: Johns Hopkins, obviously not an "estimation study", is used as a benchmark gauge of the *under-reported* so-called "Ground Truth". 


*****************

### Studies / models' versions

*
DELP model versions

DELP V1 2020-04-17 to 2020-07-04

DELP V2 2020-07-04 to 2020-11-19

DLEP V3 (could not be located)

DELP V4 2020-11-19 to when specified otherwise

DELP source for model versions: https://github.com/COVIDAnalytics/website/tree/master/data/predicted

*

IHME model versions

IHME V1 2999-99-99 to 2999-99-99  IHME_CF [Curve Fitting]

IHME V2 2999-99-99 to 2999-99-99  IHME_CF_SEIR [Curve Fitting and SEIR]

IHME V3 2999-99-99 to 2021-04-30  IHME_MS_SEIR [Mortality Spline and SEIR]

IHME V4 2021-05-06 to when specified otherwise IHME_MS_SEIR + Total Covid-19 Mortality (excess-mortality-due-covid-19)


IHME source for model versions: IHME had 3 versions before (reference here). Since the release on May 6th 2021 (http://www.healthdata.org/special-analysis/estimation-excess-mortality-due-covid-19-and-scalars-reported-covid-19-deaths), they  changed their key metric from reported deaths to the total number of COVID-19 deaths. This included estimation of ratio of total number of COVID-19 death to reported deaths from COVID-19. Hence, IHME model is labeled V4, HERE, starting from May 6, 2021.

* 

IMPE model versions

IMPE V1 2020-04-28 to 2020-05-30

IMPE V2 2020-05-31 to 2020-06-09

IMPE V3 2020-06-14 to 2020-06-26

IMPE V4 2020-06-14 to 2020-07-31

IMPE V5 2020-08-08 to 2020-11-01

IMPE V6 2020-11-10 to 2021-01-12

IMPE V7 2021-01-18 to 2021-04-24

IMPE V8 2021-05-10 to when specified otherwise

IMPE source for model versions: https://github.com/mrc-ide/global-lmic-reports/tree/master/data

*

LANL model versions

LANL V1 2020-04-05 to 2020-10-28

LANL V2 2020-10-28 to when specified otherwise

LANL source for model versions: https://covid-19.bsvgateway.org

* 

SRIV model versions

SRIV V1 2020-05-02 to when 2020-06-02
SRIV V2 2020-06-03 to when specified otherwise

SRIV source for model versions: https://github.com/scc-usc/ReCOVER-COVID-19#our-papers and https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts

*

**Note:** A known issue is existence of some discrepancies about the model version numbers currently used in variable names in the State codes and file here, and the above [Studies / models' versions](https://github.com/pourmalek/covir2/blob/main/Variable%20name%20structure.md#studies--models-versions). This is in pipeline for correction. Evidently, this does not affect anything but the punctuation accuracy in variable name assignment in data management. 

*****************

### Study || URL for estimates files

DELP https://github.com/COVIDAnalytics/website/tree/master/data/predicted

IHME http://www.healthdata.org/covid/data-downloads

IMPE https://github.com/mrc-ide/global-lmic-reports/tree/master/data

LANL https://covid-19.bsvgateway.org

SRIV https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts

UCLA https://github.com/uclaml/ucla-covid19-forecasts


<br/><br/>
<br/><br/>

* All codes are copyrighted by the author under Apache License 2.0.

* See [`LICENSE`](https://github.com/pourmalek/covir2/blob/main/LICENSE)
