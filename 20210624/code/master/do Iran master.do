

***************************************************************************
* This is "do Iran master.do"
                                                                                                          *******************
* Project: COVID-19 Iran Review No 2                                                                      * uptake 20210624 *
* Person: Farshad Pourmalek pourmalek_farshad@yahoo.com                                                   *******************
* Time (initial): 2021-04-13 

* OBJECTIVE: Get and prepare component studies' estimates for Iran
***************************************************************************


/* 

This file "do Iran master.do" was set up to be run from:
 |Users|local-user-name|Downloads|covir2-main|202YMMDD|code|master|do Iran master.do
 where 2021MMDD is the udpate date, e.g. starting with 20210405

If the first run does not go thru due to directory path clash, edit the contents within " " of the line 56 or 59 below, located beneath ****** set path based on local operating system ****** ,,, 
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
	global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/20210624/code" 
}
else if regexm(c(os),"Windows") {
	global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\20210624\code"
}
*


cd "$pathcovir2"
 
cd master





* preserve native scheme (of the local machine; will be eventually restored at the end of "do Iran merge.do")

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
LANL A04
SRIV A05

*/




* runs the do files for each study and merge them. 

* IF the target server for a given study is temp down, the respective line can be commented out. Edits would then be needed in merge.do, however. 


do "$pathcovir2/JOHN/do Iran JOHN.do" 

do "$pathcovir2/DELP/do Iran DELP.do" 

do "$pathcovir2/IHME/do Iran IHME.do" 

do "$pathcovir2/IMPE/do Iran IMPE.do" 

do "$pathcovir2/LANL/do Iran LANL.do" 

do "$pathcovir2/SRIV/do Iran SRIV.do" 

do "$pathcovir2/merge/do Iran merge.do" 








