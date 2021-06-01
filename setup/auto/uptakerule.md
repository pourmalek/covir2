uptakerule.md for covir2

Description of rule for uptakes of covir2

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

details

every day, today,

(11) check IHME estimates site http://www.healthdata.org/covid/data-downloads

(12) identify last date in text block "Previous data", e.g., "May 21, 2021", change format to 2021-05-21, name it ihme_date_web

(13) identify last row of ihme_date in [uptakes_table.csv](https://github.com/pourmalek/covir2/blob/main/setup/auto/uptakes_table.csv), e.g., 2021-05-28, name it ihme_date_vocir2

(14) if ihme_date_web > ihme_date_vocir2,

.
