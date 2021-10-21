

*****************************************************************************
* This is "do country master.do"
                                                                                                          ***************************
* Project: CovidVisualized country - countries without subnational estimates                              * this is uptake 20211022 *
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com                                            ***************************
* Time (initial): 2021-04-13 

* OBJECTIVE: Get and prepare component studies' estimates for country
*****************************************************************************

                                                                                                         
global country Iran // <<-- set here the country of choice - countries without subnational estimates     
                                                                                                         ***************************
di "$country"                                                                                  // <<<--- *   change country here   *
                                                                                                         ***************************
* To change uptake date, find and replace all, 20211022 (old), with 20211022 (new) <<--           <<<--- * change uptake date here *
                                                                                                         ***************************

/* 

This file "do country master.do" was set up to be run from:
 |Users|local-user-name|Downloads|covir2-main|202YMMDD|code|master|do country master.do
 where 2021MMDD is the udpate date, e.g. starting with 20210405

If the first run does not go thru due to directory path clash, edit the contents within " " of the line _63_ or _66_ below, located beneath ****** set path based on local operating system ****** ,,, 
,,, to reflect the location of directory /covir2-main/ or \covir2-main\ on your local machine. Path should be:


global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/202YMMDD/code/" [for Mac]

global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\202YMMDD\code\" [for Windows]



It can be moved to and run from anywhere else as far as path requirements are adjusted. 

This code was developed and run using Stata SE 14.2 on MacOS Big Sur 11.2.2 (also ran on same flavour of Stata on Windows 10).


*/



* setup Stata path by operating system 

set more off 

set mem 1000m // for older versions of Stata

clear all

dis "`c(username)'"

local usrnam = "`c(username)'"

di "`usrnam'"

****** set path based on local operating system ******

if regexm(c(os),"Mac") == 1 {
	global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/20211022/code" 
}
else if regexm(c(os),"Windows") {
	global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\20211022\code"
}
*


cd "$pathcovir2"
 
cd master





* preserve native scheme (of the local machine; will be eventually restored at the end of "do country merge.do")

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

JOHN A00

DELP A01
IHME A02
IMPE A03
LANL A04 *
SRIV A05

*/




* runs the do files for each study and merge them. 

* IF the target server for a given study is temp down, the respective line can be commented out. Edits would then be needed in merge.do, however. 


do "$pathcovir2/JOHN/do country JOHN.do" 

do "$pathcovir2/DELP/do country DELP.do" 

do "$pathcovir2/IHME/do country IHME.do" 

do "$pathcovir2/IMPE/do country IMPE.do" 

// do "$pathcovir2/LANL/do country LANL.do" // The LANL COVID-19 Team made its last real-time forecast on September 27th, 2021. [for 20210926]. This is more than two weeks old and will not be used. 

do "$pathcovir2/SRIV/do country SRIV.do" 

do "$pathcovir2/merge/do country merge.do" 








