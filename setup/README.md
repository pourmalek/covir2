## Description of rule for uptakes in this repository, covir2, and related repositories:

## repository [`CovidVisualizedCountry`](https://github.com/pourmalek/CovidVisualizedCountry) 

## repository [`CovidVisualizedGlobal`](https://github.com/pourmalek/CovidVisualizedGlobal)


***************

This is description of rule of adding uptakes to repositories covir2 , [`CovidVisualizedCountry`](https://github.com/pourmalek/CovidVisualizedCountry), and [`CovidVisualizedGlobal`](https://github.com/pourmalek/CovidVisualizedGlobal), either prospectively, i.e., uptakes with new calendar time dates, or retrospectively, i.e., uptakes with calendar time dates in the past. 

Uptake is a term used here to differentiate from updates. Updates belong to models. Uptake belongs to covir2 repository. Updates are released by studies. Uptakes are added to this repository by its creator. 

The old rule for adding uptakes to covir2 repository lacked documentation. The present rule for adding uptakes to covir2 repository is documented here. 

**The overarching principle for creation of uptakes in covir2, is creation of an uptake for each calendar date on which an uptake is available for either _IHME or IMPE_, and using the most recent update for the other study (IMPE or IHME) for that uptake.**

The rationale for not including every new update by DELP, LANL, or SRIV in the overarching principle is that it would lead to too frequent uptakes, which would defy the purpose of gaining new insight with each uptake in covir2. 

Algorithmic details of the rule for adding uptakes to covir2 repository are as follows. 


For every single calendar date, 

(1) Check for new updates by IHME.
(2) If a new update by IHME is available, start a new uptake with today's date, and use this new update by IHME.
(3) Look for latest available update by IMPE, and include that in this uptake.
(4) Look for the latest available update by LANL, and include that in this uptake.
(5) Look for updates by DELP amd SRIV for which the date is equal to date for IHME. 

(6) If no new update by IHME is available (from step 1), check for new updates by IMPE. If a new update by IMPE is available, start a new uptake with today's date, and use this new update by IMPE.
(7) Look for the latest available update by IHME, and include that in this uptake.
(8) Look for the latest available update by LANL, and include that in this uptake. 
(9) Look for updates by DELP amd SRIV for which the date is equal to date for IMPE.
(10) If no new update by IMPE is available (from step 6), there is no new uptake for this calendar date. End. 

Internal Note: If a new update by IHME is available (step 2), the URL for previous latest update needs to be changed from -copy https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip ihme-covid19.zip- to -https://ihmecovid19storage.blob.core.windows.net/archive/2021-05-07/ihme-covid19.zip- where 2021-05-07 denotes the previous latest update.


### Application of the rule for uptakes of covir2

Application of the rule for uptakes of covir2 is peformed by running ["do Studies models update dates Iran.do"](https://github.com/pourmalek/covir2/blob/main/setup/do%20Studies%20models%20update%20dates%20Iran.do) and the results are stored in [Uptakes table Iran](https://github.com/pourmalek/covir2/blob/main/setup/Uptakes%20table%20Iran.csv).

*****************

### Study || URL for estimates files

JOHN https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series

DELP https://github.com/COVIDAnalytics/website/tree/master/data/predicted

IHME http://www.healthdata.org/covid/data-downloads

IMPE https://github.com/mrc-ide/global-lmic-reports/tree/master/data

LANL https://covid-19.bsvgateway.org

SRIV https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts

UCLA https://github.com/uclaml/ucla-covid19-forecasts

*****************

### Study || URL for graphs

JOHN https://www.arcgis.com/apps/dashboards/bda7594740fd40299423467b48e9ecf6

DELP https://covidanalytics.io/projections

IHME https://covid19.healthdata.org/iran-(islamic-republic-of)?view=cumulative-deaths&tab=trend

IMPE https://github.com/mrc-ide/global-lmic-reports/tree/master/IRN

LANL https://covid-19.bsvgateway.org Click on "Global Forecasts", the second line in top left menu. Click on the country in the map, twice. This brings up a panel titled "Iran Forecast" containing text and graphs. 

SRIV https://scc-usc.github.io/ReCOVER-COVID-19/

UCLA https://covid19.uclaml.org Click on word "World" in top left, then click on the country in the map.

Worldometer https://www.worldometers.info/coronavirus/

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

IHME V1 20200325 to 20200429: Curve Fit (CF)

IHME V2 20200504 to 20200526: Curve Fit & SEIR (CF-SEIR)

IHME V3 20200529 to 20210430: Spline Fit & SEIR (SF-SEIR)

IHME V4 20210506 to when specified otherwise: SF-SEIR & excess mortality

.

. IHME V1 20200325 to 20200429: Curve Fit (CF)

Beginning March 25, IHME initially produced COVID forecasts using a statistical curve fit model (IHME-CF), which was used through April 29 for publicly released forecasts. 

. IHME V2 20200504 to 20200526: Curve Fit & SEIR (CF-SEIR)

On May 4, IHME switched to using a hybrid model, drawing on a statistical curve fit the first stage, followed a second-stage epidemiological model with susceptible, exposed, infectious, recovered compartments (SEIR). This model was used through May 26. 

. IHME V3 20200529 to 20210430: Spline Fit & SEIR (SF-SEIR)

On May 29, the curve fit stage was replaced by a spline fit to the relationship between log cumulative deaths and log cumulative cases, while the second-stage SEIR model remained the same.

Reference: [Friedman, J., Liu, P., Troeger, C.E. et al. Predictive performance of international COVID-19 mortality forecasting models. Nat Commun 12, 2609 (2021).]( https://www.nature.com/articles/s41467-021-22457-w)

. IHME V4 20210506 to : SF-SEIR & excess mortality

V4 is not a label used by IHME; it is used here. 

Reference: [Estimation of excess mortality due to COVID-19]( http://www.healthdata.org/special-analysis/estimation-excess-mortality-due-covid-19-and-scalars-reported-covid-19-deaths)


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



