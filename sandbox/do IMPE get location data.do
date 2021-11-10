
* do IMPE get location data

* change file name here: 2021-11-03_v9

cd "/Users/farshadpourmalek/Downloads/"

import delimited "2021-11-03_v9.csv", clear varnames(1)

save "2021-11-03_v9.dta", replace


* Iran 

keep if country == "Iran"

export delimited "2021-11-03_v9 Iran.csv", replace


* Canada 

use "2021-11-03_v9.dta", clear 

keep if country == "Canada"

export delimited "2021-11-03_v9 Canada.csv", replace 


* Global 

use "2021-11-03_v9.dta", clear 

* gen global sum

collapse (sum) y_025 y_25 y_median y_mean y_75 y_975, by(date compartment scenario)

gen country = "global"

export delimited "2021-11-03_v9 Global.csv", replace 

