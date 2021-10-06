* Encoding: UTF-8.
*********************************************************************************************************************************************************
*           Load and prepare file for aggregation                                                                                                                              *
*********************************************************************************************************************************************************
* change path to access aggregate file

GET
  FILE='C:\Users\niged\OneDrive - The University of Manchester\census\mcd agg.sav'.
DATASET NAME mcdagg WINDOW=FRONT.

* weight by frequencies of responses

WEIGHT BY xcount.

*********************************************************
* descriptive statistics                                      *
*********************************************************
* sex by degree

CROSSTABS
  /TABLES=sex BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* ge in 5 year bands by degree

CROSSTABS
  /TABLES=xage5 BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

 * age in 10 year bands by degree

CROSSTABS
  /TABLES=xage10 BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* age in 20 year bands by degree

CROSSTABS
  /TABLES=xage20 BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* country of birth by degree

CROSSTABS
  /TABLES=xcob BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* disability by degree

CROSSTABS
  /TABLES=xdisability BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* marital status by degree

CROSSTABS
  /TABLES=xmarstat BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* NS-SEC occupational social class (8 categories) by degree

CROSSTABS
  /TABLES=xnssec8 BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* NS-SEC occupational social class (5 categories) by degree

CROSSTABS
  /TABLES=xnssec5 BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* NS-SEC occupational social class (3 categories) by degree

CROSSTABS
  /TABLES=xnssec3 BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* race (ethnicity) by degree

CROSSTABS
  /TABLES=ethnicityew BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* year of arrival in the UK by degree

CROSSTABS
  /TABLES=xyar BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

* tenure by degree

CROSSTABS
  /TABLES=xtenure BY xdegree
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT ROW
  /COUNT ROUND CELL.

***************************************************************************************************************
* Above tables used to identify candidate independent / explanatory variables                           *
*                                                                                                                                        *
* Binary logistic regression on individuals with a degree qualification or higher                           *
***************************************************************************************************************

 DATASET ACTIVATE mcdagg.
* model 1 - sex, age, social class and tenure
 
 LOGISTIC REGRESSION VARIABLES xdegree
  /METHOD=ENTER sex xage5 xnssec8 xtenure
  /CONTRAST (sex)=indicator(1)
  /CONTRAST (xage5)=indicator(1)
  /CONTRAST (xnssec8)=indicator(1)
  /CONTRAST (xtenure)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

* add in race, disability, marital status and when cane to UK

LOGISTIC REGRESSION VARIABLES xdegree
  /METHOD=ENTER sex xage5 xnssec8 xdisability xmarstat ethnicityew xyar xtenure
  /CONTRAST (sex)=indicator(1)
  /CONTRAST (xage5)=indicator(1)
  /CONTRAST (xnssec8)=indicator(1)
  /CONTRAST (xdisability)=indicator(1)
  /CONTRAST (xmarstat)=Indicator(1)
  /CONTRAST (ethnicityew)=Indicator(1)
  /CONTRAST (xyar)=Indicator(1)
  /CONTRAST (xtenure)=Indicator(1)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).




