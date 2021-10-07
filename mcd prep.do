*******************************************************************************************************************
*   Clear memory                                                                                                  *
*   Set log and working directory                                                                                 *
*   Open file for aggregation                                                                                     *
*******************************************************************************************************************

clear all
capture log close
set more off
cd "C:\Users\niged\OneDrive - The University of Manchester\census\" /* change to working directory */
log using mcd.log, replace
use "UKDA-7682-stata11\stata11\recodev12.dta" /* change path to access downloaded file */

* recode variables
* degree
generate xdegree=hlqupuk11
recode xdegree (-9=.a) (15=1) (10/14=0) (16=0)
label variable xdegree "Degree"
label define xquallab 0 "No" 1 "Yes"
label values xdegree xquallab
* age
generate xage5=ageh
recode xage5 (1/5=.a) (6=1) (7=2) (8=3) (9=4) (10=5) (11=6) (12=7) (13=8) (14=9) (15=10) (16/19=11)
label variable xage5 "Age (5 year bands)"
label define xagelab 1 "25-29" 2 "30-34" 3 "35-39" 4 "40-44"	///
	5 "45-49" 6 "50-54" 7 "55-59" 8 "60-64" 9 "65-69" 10 "70-74" 11 "75 or over"
label values xage5 xagelab

generate xage10=xage5
recode xage10 (1/2=1) (3/4=2) (5/6=3) (7/8=4) (9/10=5) (11=6)
label variable xage10 "Age (10 year bands)"
label define xage10lab 1 "25-34" 2 "35-44" 3 "45-54" 4 "55-64" 5 "65-74" 6 "75 or over"
label values xage10 xage10lab

generate xage20=xage10
recode xage20 (1/2=1) (3/4=2) (5/6=3)
label variable xage20 "Age (20 year bands)"
label define xage20lab 1 "25-44" 2 "45-64" 3 "65 or over"
label values xage20 xage20lab

* country of birth
generate xcob=cobg
recode xcob (1/5 = 1) (6=2) (7/8 =3) (9=4) (10=5) (11=6) (12=7) (13=8) (-9=.a)
label variable xcob "Place of birth"
label define xcoblab 1 "UK" 2 "Ireland" 3 "European Union" 4 "Other Europe" 5 "Africa" 6 "Middle East or Asia" ///
                     7 "Americas" 8 "Oceania"
label values xcob xcoblab
* disability

generate xdisability = disability
recode xdisability (1=2) (2=1) (3=0) (-9 = .a)
label variable xdisability "Day to day activities limited"
label define xdislab 0 "No" 1 "A little" 2 "A lot"
label values xdisability xdislab

* marital status
generate xmarstat=marstat
recode xmarstat (1=1) (2/3 = 2) (4/5 = 3) (6=4) (-9= .a) 
label variable xmarstat "Marital status"
label define xmarlab 1 "Single" 2 "Married or civil partnership" ///
                     3 "Separated" 4 "Widowed"
label values xmarstat xmarlab					
					 
* NS-SEC (occupational social class)

generate xnssec8=nssec
recode xnssec8 (1/2=0) (3.1/3.4=1) (4.1/6=2) (7.1/7.4=3) ///
	(8.1/9.2=4) (10/11.2=5) (12.1/12.7=6) (13.1/13.5=7) (14.1/16=8) (-9=.a)
label variable xnssec8 "National Social Economic Classification (8 classes)"
label define xnssec8lab 0  "Large employers and higher managerial and administrative occupations" ///
	1 "Higher professional occupations" ///
	2 "Lower managerial, administrative and professional occupations" ///
	3 "Intermediate occupations" ///
	4 "Small employers and own account workers" ///
	5 "Lower supervisory and technical occupations" ///
	6 "Semi-routine occupations" ///
	7 "Routine occupations" ///
	8 "Never worked or long-term unemployed" ///
	9 "Not classified"
label values xnssec8 xnssec8lab

generate xnssec5=xnssec8
recode xnssec5 (0/2=1) (3=2) (4=3) (5=4) (6/7=5) (8=6) (9=7) 
label variable xnssec5 "National Social Economic Classification (5 classes)"
label define xnssec5lab 1 "Higher managerial, administrative  and professional occupations" ///
                       2 "Intermediate occupations" ///
                       3 "Small employers and own account workers" ///
                       4 "Lower supervisory and technical occupations" ///
                       5 "Semi-routine and routine occupations" ///
                       6 "Never worked and long-term unemployed" ///
                       7 "Not classified"
label values xnssec5 xnssec5lab
					   
generate xnssec3=xnssec5					   
recode xnssec3 (1=1) (2/3=2) (4/5=3) (6=4) (7=5)  
label variable xnssec3 "National Social Economic Classification (3 classes)"
label define xnssec3lab    1 "Higher managerial, administrative  and professional occupations" ///
                          2 "Intermediate occupations" ///
                          3 "Routine and manual occupations" ///
                          4 "Never worked and long-term unemployed" ///
                          5 "Not classified"
label values xnssec3 xnssec3lab

* sex
generate xsex=sex
recode xsex (2=0)
label variable xsex "Sex"
label define xsexlab 0 "Female" 1 "Male"
label values xsex xsexlab

* tenure
generate xtenure=tenduk11
recode xtenure (-9=.a) (0=1) (1/2=2) (3/4=3) (5/9=4)
label variable xtenure "Tenure of dwelling"
label define xtenlab 1 "Owned outright" 2 "Owned with a mortgage or shared ownership" ///
					 3  "Social rented" 4 "Private rented"
label values xtenure xtenlab
*migration
generate xyar=yrarr_yearg
recode xyar (-9=1) (1/4=2) (4=2) (5=3) (6=4) (7=5) (8/11=6)
label variable xyar "Year of arrival in the UK"
label define xyarlab 1 "Born in UK" 2 "before 1971" 3 "1971-1980" ///
	4 "1981-1990" 5 "1991-2000" 6 "2001-2011"
label values xyar xyarlab

* race / ethnicity
generate xeth=ethnicityew
recode xeth (-9=.a)
label variable xeth "Race (ethnicity)"
label define xethlab 1 "White British" 2 "White Irish" 3 "White other" ///
	4 "Mixed (white and black African or Caribbean)" 5 "Mixed (white and Asian or other)" ///
	6 "Indian" 7 "Pakistani" 8 "Bangladeshi" 9 "Chinese" ///
	10 "Asian other" 11 "Black African" 12 "Black Caribbean" ///
	13 "Other"
label values xeth xethlab

keep xdegree xsex xage5 xage10 xage20 xcob xdisability xmarstat  ///
	xnssec8 xnssec5 xnssec3 xeth xyar xtenure
sort xdegree xsex xage5 xage10 xage20 xcob xdisability xmarstat  ///
	xnssec8 xnssec5 xnssec3 xeth xyar xtenure
egen xcount=count(xdegree), ///
	by (xdegree xsex xage5 xage10 xage20 xcob xdisability xmarstat  ///
	xnssec8 xnssec5 xnssec3 xeth xyar xtenure)
quietly by xdegree xsex xage5 xage10 xage20 xcob xdisability xmarstat  ///
	xnssec8 xnssec5 xnssec3 xeth xyar xtenure: ///
	gen xdup =cond(_N==1,0,_n)
drop if xdup>1

save mcd_agg