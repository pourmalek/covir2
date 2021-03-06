# Troubleshooting


If "do Iran master.do" (downloaded and located in in your computer’s local directory Downloads/covir2-main/Data/master/) is initiated running, and Stata returns ERRORs or RESTARTs, the following are among possible causes and treatments. 

* **Problem** (1): If the ERROR message is about file path or directory clash, e.g., the error message reads as, unable to change to (some directory name), 
*
* **Treatment**: Make sure the file path to "do Iran master.do" is: 

"/Users/your-user-name/Downloads/covir2-main/Data/" [for Mac]

"C:\Users\your-user-name\Downloads\covir2-main\Data\" [for Windows].

Manually rearrange the directories so that the expected file path leading to "do Iran master.do" reads as mentioned above. 
*
Sometime, if the downloaded zip file is unzipped manually in Windows, there might be a possibility that the file path is not as identical to the correct path that is created after auto-inflation of the zip file and shown above. In any case, rearrange the directories so that the expected file path mentioned above leads to "do Iran master.do".
* 
*
**Problem** (2): Stata spontaneously RESTARTs with a clear start logo. 
*
If during running the codes, the demand and supply of memory needed and available for Stata get critically unbalanced, it might be possible that Stata restarts by itself without warning and shows a fresh start logo and empty memory. 
*
- **Treatment**: Provide more memory available for Stata:
- In older versions of Stata, manually set a higher memory, e.g., - set mem 1000m-. Memory no longer needs to be set in modern Statas; memory adjustments are performed on the fly automatically.
- Quit all other open and / or applications / programs until Stata runs the codes and the last output, that is "log Iran merge.smcl" is shown up. 



