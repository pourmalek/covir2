# Troubleshooting


Once you have started executing the downloaded code that is expected to be located in your local machine's |Downloads|covir2-main|Data|master|do Iran merge.do, Stata may return *ERRORs*, or may *RESTART*. The following are among possible causes and treatments. | denotes / or \ for Mac or Windows respectively. 
<br/><br/>

##KNOWN ISSUES


* **Problem** (1): If the *ERROR* message is about file path or directory clash, e.g., the error message reads as, -unable to change to (some directory name)-, 

* **Treatment**: Make sure the file path to directory |Data| is: 

"/Users/local-user-name/Downloads/covir2-main/Data/" [for Mac]

"C:\Users\local-user-name\Downloads\covir2-main\Data\\" [for Windows].

Manually rearrange the directories so that the expected file path leading to |Data| reads as mentioned above. 
<br/><br/>
Sometime, if the downloaded zip file is unzipped manually (in Windows), there might be a possibility that the file path is not identical to the correct path, that is created after auto-inflation of the zip file and shown above. In any case, rearrange the directories so that the expected file path mentioned above leads to |Data| (in root of which is located the "do Iran master.do").   
<br/><br/>
********************************************************************************************************************************************
* **Problem** (2): Stata spontaneously *RESTARTs* and shows start logo. 

If during running the codes, the demand and supply of memory needed and available for Stata get critically unbalanced, it might be possible that Stata restarts by itself without warning and shows a fresh start logo and empty memory. 
- **Treatment**: Provide more memory available for Stata:
- In older versions of Stata, manually set a higher memory, e.g., `-set mem 1000m`-. In modern Statas, memory is no longer needed to be manually set, as memory adjustments are automatically performed.
- Quit all other open applications / programs until Stata runs the codes and the last output, that is "log Iran merge.smcl" is shown up. 
<br/><br/>
********************************************************************************************************************************************
* **Problem** (3): If the *ERROR* message is about unavailability / unresponsiveness of a component study site server. Less frequently, web server unresponsiveness might occur during downloading `-renvars-` Stata command. 

* **Treatment**: Unresponsiveness of a component study site server (or `-renvars-` ) should be temporary, and is usually resolved in about a day. Alternatively, one can check the previously created results in [covir2-output](https://github.com/pourmalek/covir2-output) 
<br/><br/>
<br/><br/>


##INCIDENT ISSUES


Inform Farshad Pourmalek about incident issues not listed above. 

pourmalek_farshad@yahoo.com

********************************************************************************************************************************************


