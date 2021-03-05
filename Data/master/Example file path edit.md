* Example file path edit


Example file path edit needed for use of the Stata codes in https://github.com/pourmalek/covir2

- Go to page https://github.com/pourmalek/covir2

- Click on "Code", then "Download ZIP"

- Locate the downloaded "covir2-main" directory

- Locate file "do Iran master.do" in /covir2-main/Data/master/

- Open do file and edit the following line:

global pathcovir2 "/Users/farshadpourmalek/Downloads/covir2-main/data/"

in order to type in the file path for your downloaded "covir2-main" directory (e.g. /Users/farshadpourmalek/Downloads/covir2-main, or C:\Users\farshadpourmalek\)

e.g. to:

global pathcovir2 "/Users/farshadpourmalek/Downloads/covir2-main/data/"

- Save the edited /covir2-main/Data/master/do Iran master.do

- Run the saved /covir2-main/Data/master/do Iran master.do

- Go to /covir2-main/Data/merge/ and view the produced graphs stored in PDF files (starting with graph 11 COVID-19 daily deaths, Iran, reference scenarios, with DELPHI.PDF)
