
/* Edit the contents within " " of 
"/Users/farshadpourmalek/Documents/COVID Iran - Rapid review of estimates of COVID Iran - No 2/data/"
below to reflect where the directory /data/ or \data\ is located on your machine.*/

* This code ran using Stata SE 14.2 on MacOS Big Sur 11.2.2

clear all

global pathcovir2 "/Users/farshadpourmalek/Documents/COVID Iran - Rapid review of estimates of COVID Iran - No 2/data/"

cd "$pathcovir2"

cd master

***************************************************************************
* This is "do Iran master.do"

* Project: Rapid review of estimates of COVID Iran - No 2
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com
* Time: 2021-02-10

* OBJECTIVE: Get and prepare component studies' estimates for Iran, Locate peak dates and values
***************************************************************************


/* studies:
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








