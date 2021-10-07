################################################################################
#                                                                              #
# Load census microdata to aggregate                                           #
# clear memory                                                                 #
# set working directory                                                        #
#                                                                              #
################################################################################
# Clear memory
rm(list=ls(all=TRUE))
# load required package
library("haven")
library("dplyr")
library("expss")
library("questionr")
# set working directory and read in SPSS file
setwd("C:\\Users\\niged\\OneDrive - The University of Manchester\\census")
fdata <- read_sav("UKDA-7682-SPSS\\spss\\spss19\\recodev12.sav")

# set up categorical variables - remove others
kdata=subset(fdata, select = c("hlqupuk11", "ageh", "cobg", "disability", 
                               "marstat", "nssec", "sex", "tenduk11", 
                               "yrarr_yearg", "ethnicityew"))

kdata=subset(kdata, kdata$ageh >=6)

# uncomment if short of memory to remove SPSS file
# rm(fdata) 

# recoding
# set missing values

kdata[kdata == -9] <- NA

# set new categories
# degree
kdata$xdegree <- as.integer(kdata$hlqupuk11)
kdata["xdegree"][kdata["hlqupuk11"] !=15] <- 0
kdata["xdegree"][kdata["hlqupuk11"] ==15] <- 1
#age

kdata$xage5 <- as.integer(kdata$ageh-5)
kdata["xage5"][kdata["xage5"] >=11] <- 11
kdata$xage10 <- as.integer((kdata$xage5+1)/2)
kdata$xage20 <- as.integer((kdata$xage10+1)/2)

# country of birth
kdata$xcob <- as.integer(kdata$cobg)
kdata["xcob"][kdata["cobg"] >=5] <- 1
kdata["xcob"][kdata["cobg"] ==6] <- 2
kdata["xcob"][kdata["cobg"] ==7] <- 3
kdata["xcob"][kdata["cobg"] ==8] <- 3
kdata["xcob"][kdata["cobg"] ==9] <- 4
kdata["xcob"][kdata["cobg"] ==10] <- 5
kdata["xcob"][kdata["cobg"] ==11] <- 6
kdata["xcob"][kdata["cobg"] ==12] <- 7
kdata["xcob"][kdata["cobg"] ==13] <- 8

# disability
kdata$xdisability <- as.integer(kdata$disability)
kdata["xdisability"][kdata["disability"] ==1] <- 2
kdata["xdisability"][kdata["disability"] ==2] <- 1
kdata["xdisability"][kdata["disability"] ==3] <- 0

# Marital status
kdata$xmarstat <- as.integer(kdata$marstat)
kdata["xmarstat"][kdata["marstat"] ==1] <- 1
kdata["xmarstat"][kdata["marstat"] ==2] <- 2
kdata["xmarstat"][kdata["marstat"] ==3] <- 2
kdata["xmarstat"][kdata["marstat"] ==4] <- 3
kdata["xmarstat"][kdata["marstat"] ==5] <- 3
kdata["xmarstat"][kdata["marstat"] ==6] <- 4

# National Social Economic classification (8 classes)
kdata$xnssec8 <- as.integer(round(kdata$nssec))
kdata["xnssec8"][kdata["xnssec8"] ==1] <- 0
kdata["xnssec8"][kdata["xnssec8"] ==2] <- 0
kdata["xnssec8"][kdata["xnssec8"] ==3] <- 1
kdata["xnssec8"][kdata["xnssec8"] ==4] <- 2
kdata["xnssec8"][kdata["xnssec8"] ==5] <- 2
kdata["xnssec8"][kdata["xnssec8"] ==6] <- 2
kdata["xnssec8"][kdata["xnssec8"] ==7] <- 3
kdata["xnssec8"][kdata["xnssec8"] ==8] <- 4
kdata["xnssec8"][kdata["xnssec8"] ==9] <- 4
kdata["xnssec8"][kdata["xnssec8"] ==10] <- 5
kdata["xnssec8"][kdata["xnssec8"] ==11] <- 5
kdata["xnssec8"][kdata["xnssec8"] ==12] <- 6
kdata["xnssec8"][kdata["xnssec8"] ==13] <- 7
kdata["xnssec8"][kdata["xnssec8"] ==14] <- 8
kdata["xnssec8"][kdata["xnssec8"] ==15] <- 9
kdata["xnssec8"][kdata["xnssec8"] ==16] <- 9
kdata["xnssec8"][kdata["xnssec8"] ==17] <- 9

# National Social Economic classification (5 classes)
kdata$xnssec5 <- as.integer(kdata$xnssec8)
kdata["xnssec5"][kdata["xnssec8"] ==0] <- 1
kdata["xnssec5"][kdata["xnssec8"] ==1] <- 1
kdata["xnssec5"][kdata["xnssec8"] ==3] <- 2
kdata["xnssec5"][kdata["xnssec8"] ==4] <- 3
kdata["xnssec5"][kdata["xnssec8"] ==5] <- 4
kdata["xnssec5"][kdata["xnssec8"] ==6] <- 5
kdata["xnssec5"][kdata["xnssec8"] ==7] <- 5
kdata["xnssec5"][kdata["xnssec8"] ==8] <- 6
kdata["xnssec5"][kdata["xnssec8"] ==9] <- 7

# National Social Economic classification (3 classes)
kdata$xnssec3 <- as.integer(kdata$xnssec5)
kdata["xnssec3"][kdata["xnssec5"] ==1] <- 1
kdata["xnssec3"][kdata["xnssec5"] ==2] <- 2
kdata["xnssec3"][kdata["xnssec5"] ==3] <- 2
kdata["xnssec3"][kdata["xnssec5"] ==4] <- 3
kdata["xnssec3"][kdata["xnssec5"] ==5] <- 3
kdata["xnssec3"][kdata["xnssec5"] ==6] <- 4
kdata["xnssec3"][kdata["xnssec5"] ==7] <- 5

# Sex
kdata$xsex <- as.integer(kdata$sex)
kdata["xsex"][kdata["sex"] == 2] <- 0
kdata["xsex"][kdata["sex"] == 1] <- 1

# Tenure
kdata$xtenure <- as.integer(kdata$tenduk11)
kdata["xtenure"][kdata["tenduk11"] ==0] <- 1
kdata["xtenure"][kdata["tenduk11"] ==1] <- 2
kdata["xtenure"][kdata["tenduk11"] ==2] <- 2
kdata["xtenure"][kdata["tenduk11"] ==3] <- 3
kdata["xtenure"][kdata["tenduk11"] ==4] <- 3
kdata["xtenure"][kdata["tenduk11"] >=5] <- 4

# migration
kdata$xyar <- as.integer(kdata$yrarr_yearg)
kdata$xyar[is.na(kdata$xyar)] <- 1
kdata["xyar"][kdata["xyar"] ==2] <- 2
kdata["xyar"][kdata["xyar"] ==3] <- 2
kdata["xyar"][kdata["xyar"] ==4] <- 2
kdata["xyar"][kdata["xyar"] ==5] <- 3
kdata["xyar"][kdata["xyar"] ==6] <- 4
kdata["xyar"][kdata["xyar"] ==7] <- 5
kdata["xyar"][kdata["xyar"] >=8] <- 6

# race / ethnicity
kdata$xeth <- as.integer(kdata$ethnicityew)

# remove working variables
kdata=subset(kdata, select = c("xdegree", "xage5", "xage10", "xage20", "xcob",
                               "xdisability", "xmarstat", "xnssec8", "xnssec5",
                               "xnssec3", "xsex", "xtenure", "xyar", "xeth"))




# set variable descriptions
kdata = apply_labels(kdata,
                     xdegree = "Degree level qualification",
                     xage5 = "Age (5 year bands)",
                     xage10 = "Age (10 year bands)",
                     xage20 = "Age (20 year bands)",
                     xcob = "Country of birth",
                     xdisability = "Limiting long-term illness", 
                     xmarstat = "Marital status",
                     xnssec8 = "National Socio-Economic class (8 categories)",
                     xnssec5 = "National Socio-Economic class (5 categories)",
                     xnssec3 = "National Socio-Economic class (3 categories)",
                     xsex = "Sex", 
                     xtenure = "Tenure of dwelling",
                     xyar = "Year of arrival in the UK",
                     xeth = "Race / ethnic group")
                     
# convert all variables to factors
# and set category labels
kdata$xdegree <- factor(kdata$xdegree, 
                           labels=c("No","Yes"))
kdata$xage5 <- factor(kdata$xage5, 
                      labels=c("25 - 29", 
                                "30 - 34",  
                                "35 - 39",  
                                "40 - 44",  
                                "45 - 49",  
                                "50 - 54",
                                "55 - 59",
                                "60 - 64",
                                "65 - 69",
                                "70 - 74",
                                "75 or over"))

kdata$xage10 <- factor(kdata$xage10,
                       labels=c("25 - 34",  
                                "35 - 44",  
                                "45 - 54",  
                                "55 - 64",  
                                "55 - 64",  
                                "75 or over"))
kdata$xage20 <- factor(kdata$xage20,
                       labels=c("25 - 44",  
                                "45 - 64",  
                                "65 or over"))
kdata$xcob <- factor(kdata$xcob, 
                     labels=c("1 UK", 
                               "2 Ireland", 
                               "3 European Union",
                               "4 Other Europe", 
                               "5 Africa",
                               "6 Middle East or Asia",
                               "7 Americas",
                               "8 Oceania"))
kdata$xdisability <- factor(kdata$xdisability,
                            labels=c("0 No",
                                      "1 A little",
                                      "2 A lot"))
kdata$xmarstat <- factor(kdata$xmarstat,
                         labels=c("1 Single",
                                  "2 Married or civil partnership",
                                  "3 Separated",
                                  "4 Widowed"))
kdata$xnssec8 <- factor(kdata$xnssec8,
                        labels=c("Large employers and higher managerial and administrative occupations",
	                               "Higher professional occupations",
	                               "Lower managerial, administrative and professional occupations",
	                               "Intermediate occupations",
	                               "Small employers and own account workers",
	                               "Lower supervisory and technical occupations",
	                               "Semi-routine occupations",
	                               "Routine occupations",
	                               "Never worked or long-term unemployed",
	                               "Not classified"))
kdata$xnssec5 <- factor(kdata$xnssec5,
                        labels=c("Higher managerial, administrative and professional occupations",
                                 "Intermediate occupations",
                                 "Small employers and own account workers",
                                 "Lower supervisory and technical occupations",
                                 "Semi-routine and routine occupations",
                                 "Never worked and long-term unemployed",
                                 "Not classified"))
kdata$xnssec3 <- factor(kdata$xnssec3,
                        labels=c("Higher managerial, administrative  and professional occupations",
                                 "Intermediate occupations",
                                 "Routine and manual occupations",
                                 "Never worked and long-term unemployed",
                                 "Not classified"))
kdata$xsex <- factor(kdata$xsex,
                     labels=c("Female",
                              "Male"))
kdata$xtenure <- factor(kdata$xtenure, 
                        labels=c("1 Owned outright",
                                 "2 Owned with a mortgage or shared ownership",
                                 "3 Social rented",
                                 "4 Private rented"))
kdata$xyar <- factor(kdata$xyar,
                     labels=c("1 Born in UK",
                              "2 before 1971",
                              "3 1971-1980",
                              "4 1981-1990",
                              "5 1991-2000",
                              "6 2001-2011"))
kdata$xeth <- factor(kdata$xeth,
                     labels=c("1 White British",
                              "2 White Irish",
                              "3 White other",
                              "4 Mixed (white and black African or Caribbean)",
                              "5 Mixed (white and Asian or other)",
                              "6 Indian",
                              "7 Pakistani",
                              "8 Bangladeshi",
                              "9 Chinese",
                              "10 Asian other",
                              "11 Black African",
                              "12 Black Caribbean",	
                              "13 Other"))
# group by variables

mcdagg <- group_by(kdata, xdegree, xage5, xage10, 
                   xage20, xcob, xdisability, 
                   xmarstat, xnssec8, xnssec5, 
                   xnssec3, xsex, xtenure, 
                   xyar, xeth)
# summarise group (to reduce to single entry) with count
mcdagg2 <- summarise(mcdagg,xcount=n())
save(mcdagg2, file="mcd agg.Rdata")

