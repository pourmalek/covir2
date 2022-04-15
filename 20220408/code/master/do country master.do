

*****************************************************************************
* This is "do country master.do"
                                                                                                          
* Project: CovidVisualized country - countries without subnational estimates                             
* Person: Farshad Pourmalek pourmalek_farshad at yahoo dot com                                            
* Time (initial): 2021-04-13 

* OBJECTIVE: Get and prepare component studies' estimates for country
*****************************************************************************

 * this is uptake ************ 20220408 ************

                                                                                                         
global country Iran // <<-- set here the country of choice - countries without subnational estimates     
                                                                                                         ***************************
di "$country"                                                                                  // <<<--- *   change country here   *
                                                                                                         ***************************
* To change uptake date, find and replace all, 20220408 (old), with 20220408 (new) <<--           <<<--- * change uptake date here *
*                                           1/ --------                                                  ***************************

* To change uptake date in individual do files for models, change the following dates:

global DELPdate 20220408 
*            2/ --------

global IHMEdate 20220408
*            3/ --------

global IMPEdate 2022-01-31_v9 
*            4/ -------------

global SRIVdate 2022-04-08
*            5/ ----------

																		 
					
		
******************************************************		
		

* setup Stata path by operating system 

set more off 

set mem 1000m // for older versions of Stata

clear all

dis "`c(username)'"

local usrnam = "`c(username)'"

di "`usrnam'"

****** set path based on local operating system ******

if regexm(c(os),"Mac") == 1 {
	global pathcovir2 "/Users/`usrnam'/Downloads/covir2-main/20220408/code" 
}
else if regexm(c(os),"Windows") {
	global pathcovir2 = "C:\Users\\`usrnam'\Downloads\covir2-main\20220408\code"
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






* runs the do files for each study and merge them: 

* IF the target server for a given study is temp down, the respective line can be commented out. Edits would then be needed in merge.do, however. 


do "$pathcovir2/JOHN/do country JOHN.do" 

do "$pathcovir2/DELP/do country DELP.do" 

do "$pathcovir2/IHME/do country IHME.do" 

do "$pathcovir2/IMPE/do country IMPE.do" 

// do "$pathcovir2/LANL/do country LANL.do" // The LANL COVID-19 Team made its last real-time forecast on September 27th, 2021. [for 20210926]. This is more than two weeks old and will not be used. 

do "$pathcovir2/SRIV/do country SRIV.do" 

do "$pathcovir2/merge/do country merge.do" 








