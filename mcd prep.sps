* Encoding: UTF-8.
*********************************************************************************************************************************************************
*           Load and prepare file for aggregation                                                                                                                              *
*********************************************************************************************************************************************************
* change path to access downloaded file

GET
  FILE='C:\Users\niged\OneDrive - The University of Manchester\census\UKDA-7682-spss\spss\spss19\recodev12.sav'.
DATASET NAME microdata WINDOW=FRONT.

* selected variables - recoding
* age (5, 10 and 20 year bands)

* remove all aged under 25

SELECT IF ageh GE 6.
EXECUTE.

COMPUTE xage5 = ageh.
IF (xage5 > 15)  xage5=16.
VARIABLE LABELS xage5 'Age in 5 year bands (starting at 25)'.
VALUE LABELS xage5 6 '25 - 29' 7 '30 - 34' 8 '35 - 39' 9 '40 - 44' 10 '45 - 49' 11 '50 - 54' 12  '55 - 59' 13 '60 - 64' 14 '65 - 69' 15 '70 - 74'  16 '75 or over'.
MISSING VALUES xage5 (-9).

RECODE xage5 (-9=-9) (6 thru 7=1) (8 thru 9=2) (10 thru 11=3) (12 thru 13=4) (14 thru 15=5) (16 thru HIGH = 6) INTO xage10.
VARIABLE LABELS xage10 'Age in 10 year bands (starting at 25)'.
VALUE LABELS xage10 1 '25 - 34' 2 '35 - 44' 3 '45 - 54' 4 '55 - 64' 5 '65 - 74' 6 '75 or over'.
MISSING VALUES xage10 (-9).

RECODE xage10 (-9=-9) (1 thru 2=1) (3 thru 4=2) (5 thru HIGH=3)  INTO xage20.
VARIABLE LABELS xage20 'Age in 20 year bands (starting at 25)'.
VALUE LABELS xage20 1 '25 - 44' 2 '45 - 64' 3 '65 or over'.
MISSING VALUES xage20 (-9).

* highest level of qualification

RECODE hlqupuk11 (15=1) (-9=-9) (ELSE=0) INTO xdegree.
VARIABLE LABELS xdegree 'Has a degree'.
VALUE LABELS xdegree 0 'No' 1 'Yes' -9 'Missing'.
MISSING VALUES xdegree (-9).

                        
* country of birth

RECODE cobg (1 thru 5 = 1) (6=2) (7 thru 8 =3) (9=4) (10=5) (11=6) (12=7) (13=8) (-9=-9) INTO xcob.
VARIABLE LABELS xcob 'Place of birth'.
VALUE LABELS xcob 1 'UK' 2 'Ireland' 3 'European Union' 4 'Other Europe' 5 ' Africa' 6 'Middle East or Asia'
                                  7 'Americas' 8 'Oceania' -9 'Missing'.
MISSING VALUES xcob (-9).


* disability

RECODE disability (1=2) (2=1) (3=0) (-9=-9) INTO xdisability.
VARIABLE LABELS xdisability 'Day to day activities limited'.
VALUE LABELS xdisability 0 'No' 1 'A little' 2 'A lot' -9 'Missing'.
MISSING VALUES xdisability (-9).

* marital status

RECODE marstat (1=1) (2 thru 3 = 2) (4 thru 5 = 3) (6=4) (-9=-9) INTO xmarstat.
VARIABLE LABELS xmarstat 'Marital status'.
VALUE LABELS xmarstat 1 'Single'
                                       2 'Married or civil partnership'
                                       3 'Separated'
                                       4 'Widowed'
                                       -9 'Missing'.
MISSING VALUES xmarstat (-9).

* Social class

RECODE nssec (1 thru 2 = 1.1) (3.1 thru 3.4 = 1.2) (4.1 thru 6 = 2) (7.1 thru 7.4 = 3) (8.1 thru 9.2 = 4) (10 thru 11.2 = 5) (12.1 thru 12.7 = 6)
                       (13.1 thru 13.5 = 7) (14.1 thru 14.2 = 8) (-9 = -9) (ELSE = 9) INTO xnssec8.
VARIABLE LABELS xnssec8 'National Social Economic Classification (8 classes)'.
VALUE LABELS xnssec8 1.1 'Large employers and higher managerial and administrative occupations'
                          1.2 'Higher professional occupations'
                          2 'Lower managerial, administrative and professional occupations'
                          3 'Intermediate occupations'
                          4 'Small employers and own account workers'
                          5 'Lower supervisory and technical occupations'
                          6 'Semi-routine occupations'
                          7 'Routine occupations'
                          8 'Never worked and long-term unemployed'
                          9 'Not classified'
                          -9 'Missing'.
MISSING VALUES xnssec8 (-9).

RECODE xnssec8 (1.1 thru 2 = 1) (3 = 2) (4 = 3) (5 = 4) (6 thru 7 = 5) (8 = 6) (9 = 7) (-9 = -9) INTO xnssec5.
VARIABLE LABELS xnssec5 'National Social Economic Classification (5 classes)'.
VALUE LABELS xnssec5 1 'Higher managerial, administrative  and professional occupations'
                          2 'Intermediate occupations'
                          3 'Small employers and own account workers'
                          4 'Lower supervisory and technical occupations'
                          5 'Semi-routine and routine occupations'
                          6 'Never worked and long-term unemployed'
                          7 'Not classified'
                          -9 'Missing'.
MISSING VALUES xnssec5 (-9).

RECODE xnssec5 (1 = 1) (2 thru 3 = 2) (4 thru 5 = 3) (6 = 4) (7 = 5)  (-9 = -9) INTO xnssec3.
VARIABLE LABELS xnssec3 'National Social Economic Classification (3 classes)'.
VALUE LABELS xnssec3 1 'Higher managerial, administrative  and professional occupations'
                          2 'Intermediate occupations'
                          3 'Routine and manual occupations'
                          4 'Never worked and long-term unemployed'
                          5 'Not classified'
                          -9 'Missing'.
MISSING VALUES xnssec3 (-9).


* Year of arrival in the UK

RECODE yrarr_yearg (-9 = 1) (1 thru 4 = 2) (5 = 3) (6 = 4) (7 = 5) (8 thru high = 6) INTO xyar.
VARIABLE LABELS xyar 'Year of arrival in UK'.
VALUE LABELS xyar 1 'Born in UK' 2 'before 1971' 3 '1971 - 1980' 4 '1981 - 1990' 5 '1991 - 2000' 6 '2001 - 2011'.

* tenure

RECODE tenduk11 (0 = 1) ( 1 thru 2 = 2) (3 thru 4 = 3) (5 thru high = 4) (-9 = -9) INTO xtenure.
VARIABLE LABELS xtenure 'Household tenure'.
VALUE LABELS xtenure 1 'Owns outright' 2 'Owns with a mortgage or shared ownership' 3 'Social rent' 4 'Private rented'.
MISSING VALUES xtenure(-9).
EXECUTE. 

*******************************************************************************************************************
* Create aggregate file by variables selected                                                                               *
*   1)   Sort data into order to allow aggregate function to work                                                     *
*   2)   Create aggregate with count of unique combinations to use for weighting                            *
*******************************************************************************************************************

DATASET ACTIVATE microdata.
DATASET DECLARE mcdagg.
SORT CASES BY xdegree sex xage5 xage10 xage20 xcob xdisability xmarstat xnssec8 xnssec5 xnssec3 ethnicityew xyar xtenure.
AGGREGATE
  /OUTFILE='mcdagg'
  /PRESORTED
  /BREAK=xdegree sex xage5 xage10 xage20 xcob xdisability xmarstat xnssec8 xnssec5 xnssec3 ethnicityew xyar xtenure
  /xcount=N.

DATASET ACTIVATE mcdagg.
SAVE   OUTFILE='C:\Users\niged\OneDrive - The University of Manchester\census\mcd agg.sav'.
