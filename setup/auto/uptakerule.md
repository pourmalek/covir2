### uptakerule.md for covir2

#### Description of rule for uptakes of covir2

This is description of rule of adding uptakes to covir2 repository, either prospectively, i.e., uptakes with new calendar time dates, or retrospectively, i.e., uptakes with calendar time dates in the past.

Uptake is a term used here to differentiate from updates. Updates belong to models. Uptake belongs to covir2 repository. Updates are released by studies. Uptakes are added to this repository by its creator.

The old rule for adding uptakes to covir2 repository lacked documentation. The present rule for adding uptakes to covir2 repository is documented here.

The overarching principle for creation of uptakes in covir2, is creation of an uptake for each calendar date on which an uptake is available for either IHME or IMPE, and using the most recent update for the other study (IMPE or IHME) for that uptake.

The rationale for not including every new update by DELP, LANL, or SRIV in the overarching principle is that it would lead to too frequent uptakes, which would defy the purpose of gaining new insight with each uptake in covir2.

Algorithmic details of the rule for adding uptakes to covir2 repository are as follows.

For every single calendar date,

(1) Check for new updates by IHME. (2) If a new update by IHME is available, start a new uptake with today's date, and use this new update by IHME. (3) Look for latest available update by IMPE, and include that in this uptake. (4) Look for the latest available update by LANL, and include that in this uptake. (5) Look for updates by DELP amd SRIV for which the date is equal to date for IHME.

(6) If no new update by IHME is available (from step 1), check for new updates by IMPE. If a new update by IMPE is available, start a new uptake with today's date, and use this new update by IMPE. (7) Look for the latest available update by IHME, and include that in this uptake. (8) Look for the latest available update by LANL, and include that in this uptake. (9) Look for updates by DELP amd SRIV for which the date is equal to date for IMPE. (10) If no new update by IMPE is available (from step 6), there is no new uptake for this calendar date. End.

Internal Note: If a new update by IHME is available (step 2), the URL for previous latest update needs to be changed from -copy https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip ihme-covid19.zip- to -https://ihmecovid19storage.blob.core.windows.net/archive/2021-05-07/ihme-covid19.zip- where 2021-05-07 denotes the previous latest update.


**********
**********

### Study || URL for estimates files

DELP https://github.com/COVIDAnalytics/website/tree/master/data/predicted

IHME http://www.healthdata.org/covid/data-downloads

IMPE https://github.com/mrc-ide/global-lmic-reports/tree/master/data

LANL https://covid-19.bsvgateway.org

SRIV https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts

UCLA https://github.com/uclaml/ucla-covid19-forecasts/tree/master/current_projection

**********
**********

### details for auto-uptake

every day, today, name today's date today_date


* (A) check IHME

* expected update relases frequency for IHME: weekly

(11) check IHME estimates site http://www.healthdata.org/covid/data-downloads

(12) identify last date in text block "Previous data", e.g., "May 21, 2021", change format to 2021-05-21, name it ihme_date_web

(13) **identify last row of ihme_date in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv), e.g., 2021-05-28, name it ihme_date_covir2**

(14) if ihme_date_web > ihme_date_vocir2, create a new uptake, and modify in the latest previous uptake, for the latter, open:

https://github.com/pourmalek/covir2/blob/main/20210528/code/IHME/do%20Iran%20IHME.do

and change the IHME download estimates path from: 

copy https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip ihme-covid19.zip

to:

copy https://ihmecovid19storage.blob.core.windows.net/archive/2021-05-28/ihme-covid19.zip ihme-covid19.zip

where 2021-05-28 is replaced by ihme_date_covir2 (and run the code to make sure it works and produce new logs)

(15) for creation of THE new uptake, add a new line (new_line) to [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv) by replacing the empty uptake_date[new_line] with today_date, 

(16) replace the empty uptake_no[new_line] with uptake_no[previous_line], in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)

(17) replace the empty ihme_date[new_line] with today_date, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)

(18) replace the empty uptake_trigger[new_line] with ihme, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)



* (B) check IMPE for latest update relative to this new uptake, where this new uptake is triggered by the new IHME update

* expected update relases frequency for IMPE: almost weekly

(21) check IMPE estimates site http://www.healthdata.org/covid/data-downloads

(22) **identify latest update in this format: 2021-05-22_v8.csv.zip**, change format to 2021-05-22, name it impe_date_web 

(23) identify impe_date[previuos_line] and name it impe_date_covir2, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)

(24) replace impe_date[new_line] with impe_date_web, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv). IMPE and IHME usually do not release updates in the same day. if they do, replace uptake_trigger[new_line] with value ihme to value both 


* (C) check other studies 

* DELP

* expected update relases frequency for DELP: daily

(31) check DELP estimates site https://github.com/COVIDAnalytics/website/tree/master/data/predicted

(32) **identify largest impe_date_web from this format: Global_V4_20210601.csv, where today_date >= impe_date_web**, i.e. DELP update for today or if no DELP update for today, the latest DELP update before today. expected update relases frequency for DELP: daily

(33) replace delp_date[new_line] with delp_date_web, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)


* LANL

* expected update relases frequency for LANL: every 3-4 days

(34) check LANL estimates site https://covid-19.bsvgateway.org, tab "Model Outputs", tab "Global"

(35) **identify first "Forecast Date", e.g., 2021-05-26, name it lanl_date_web, identify largest lanl_date_web where today_date >= lanl_date_web**, i.e. LANL update for today or if no LANL update for today, the latest DELP update before today

(36) replace lanl_date[new_line] with lanl_date_web, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)


* SRIV

* expected update relases frequency for SRIV: daily

(37) check SRIV estimates site https://covid-19.bsvgateway.org

(38) **identify latest update in this format: 2021-06-01, name it sriv_date_web, identify largest sriv_date_web where today_date >= sriv_date_web**, i.e. SRIV update for today or if no SRIV update for today, the latest SRIV update before today

(39) replace sriv_date[new_line] with sriv_date_web, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)


* UCLA

* expected update relases frequency for UCLA: ?

(40) check UCLA estimates site https://github.com/uclaml/ucla-covid19-forecasts/tree/master/current_projection, 

(41) identify pred_world_new.csv, identify the value in this row in third columns, under col heading "History", e.g., 26 days ago, name it ucla_days_ago

(42) replace ucla_date[new_line] = today_date - ucla_days_ago, in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv)









