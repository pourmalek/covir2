UCLA model

https://github.com/uclaml/ucla-covid19-forecasts/tree/master/current_projection

https://covid19.uclaml.org

https://www.medrxiv.org/content/10.1101/2020.05.24.20111989v1.full.pdf




* Get UCLA estimates 

copy https://raw.githubusercontent.com/uclaml/ucla-covid19-forecasts/master/current_projection/pred_world.csv pred_world.csv

import delimited using pred_world.csv, clear varnames(1)

keep if region == "Iran"


rename date date_original

gen year = substr(date_original,1,4) 
gen month = substr(date_original,6,2) 
gen day = substr(date_original,9,2) 
egen date2 = concat(day month year)
gen date = date(date2, "DMY", 2050)
format date %tdDDMonCCYY
codebook date

drop year month day date2

* 08nov2020,15feb2021
