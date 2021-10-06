*******************************************************************************************************************
*   Look at variables individually and                                                                            *
*   in relation to having a degree                                                                                *
*******************************************************************************************************************

clear all
capture log close
set more off
cd "C:\Users\niged\OneDrive - The University of Manchester\census"
log using mcd.log, replace
use "mcd_agg.dta" 

tab xnssec8 xdegree[fweight=xcount], chi2 V
tab xnssec5 xdegree [fweight=xcount], chi2 V
tab xnssec3 xdegree [fweight=xcount], chi2 V
tab xage5 xdegree [fweight=xcount], chi2 V
tab xage10 xdegree [fweight=xcount], chi2 V
tab xage20 xdegree [fweight=xcount], chi2 V
tab xsex xdegree [fweight=xcount], chi2 V
tab xeth xdegree [fweight=xcount], chi2 V
tab xyar xdegree [fweight=xcount], chi2 V
tab xdisability xdegree [fweight=xcount], chi2 V
tab xtenure xdegree [fweight=xcount], chi2 V

logit xdegree i.xsex i.xage5 i.xnssec8 i.xtenure, or allbaselevels

estat ic
estat gof [fweight=xcount]
estat gof [fweight=xcount], group(10)

logit xdegree i.xsex i.xage5 i.xnssec8 i.xdisability i.xmarstat ///
		i.xeth i.xyar i.xtenure , or allbaselevels

estat ic
estat gof [fweight=xcount]
estat gof [fweight=xcount], group(10)
