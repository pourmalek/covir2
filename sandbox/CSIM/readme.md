# CSIM = COVID-19 Simulation (labeled CSIM in this repo) 

MRC Centre for Global Infectious Disease Analysis, Imperial College London

Note: Simulation outputs should not be interpreted as predictions


## COVID-19 Scenario Analysis Tool - https://covidsim.org/

*******

### Assessment initiale


* Pluses:

Potentially usable for **subnational** locations - inputs 

Accepts different input types for **vaccines** - inputs

Health care demand - outputs

Vaccine allocation (according to the selected strategy) - outputs (graphs)

Different combinations of input settings ('scenarios') can be chosen and model executed, and the model outputs exported in csv file; then different scenarios can be created and compared


* Minuses:

No uncertainty estimates - outputs

NPIs cannot be fed into model directly, but the model can intake different values of R for different time intervals - inputs

Variants seem to not be present - inputs


*******

### Use CSIM COVIDSIM 

(1) In home page of covidsim.org, change current country to desired country

https://covidsim.org/v4.20210430/?place=ca

https://covidsim.org/v4.20210430/?place=ir

(2) Change inputs on the left panel, or leave as is for default settings.

(3) Tick on "counterfactual current infections" and "current infections" on the right side.

(4) Beneath the "Rt" on the right side, click on "Generate Reff".

(5) Click "Data Export" on top left, downloads "ir_g169169_c4879.csv".


*******

## Codes: nimue, squire

Researchers who are familiar with modelling should consider the equivalent R package “nimue” which is available here (https://github.com/mrc-ide/nimue). Please note that this package is under active development.


Nimue is an extension to the [squire package](https://mrc-ide.github.io/squire/) that allows vaccination to be included. For detailed information on the base model structure and parameterisation please visit the [squire webpage](https://mrc-ide.github.io/squire/).


*******

## Default page for Iran


https://covidsim.org/v4.20210430/?place=ir


Default:

![image](https://user-images.githubusercontent.com/30849720/119897623-8bffe380-bef5-11eb-8378-056ef64ff732.png)

*

Add infections:

![image](https://user-images.githubusercontent.com/30849720/119897731-b81b6480-bef5-11eb-81cb-942c7326baf6.png)

*

Generate Reff

![image](https://user-images.githubusercontent.com/30849720/119899621-34af4280-bef8-11eb-9f92-048d01055ecf.png)


*****


### Documentation:

https://covidsim.org/v4.20210430/User%20guide%20covidsim%2004-02-2021.pdf

https://www.youtube.com/watch?v=v3-rQU2qf00&t=4s 

https://covidsim.org/v4.20210430/research.html

https://covidsim.org/v4.20210430/faq.html

https://covidsim.org/v4.20210430/contact.html

*


*

https://spiral.imperial.ac.uk:8443/bitstream/10044/1/77735/10/2020-03-26-COVID19-Report-12.pdf

https://www.imperial.ac.uk/media/imperial-college/medicine/mrc-gida/15-09-2020-COVID19-Report-31.pdf

https://www.imperial.ac.uk/media/imperial-college/medicine/mrc-gida/2020-09-25-COVID19-Report-33.pdf

