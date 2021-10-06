################################################################################
#                                                                              #
# Load aggregate                                                               #
# clear memory                                                                 #
# set working directory                                                        #
#                                                                              #
################################################################################
# Clear memory
rm(list=ls(all=TRUE))
# load required package
library("questionr")
library("rcompanion")

# set working directory and read in SPSS file
setwd("C:\\Users\\niged\\OneDrive - The University of Manchester\\census")
load("mcd agg.Rdata")
###################################################
#  Explore associations between having a degree   #
#  and candidate explanatory variables            #
###################################################

# uncomment to create file to review output later
# sink("Rtable.txt")
varray=data.frame(mcdagg2$xage5, mcdagg2$xage10, mcdagg2$xage20,
                  mcdagg2$xcob, mcdagg2$xdisability, mcdagg2$xmarstat,
                  mcdagg2$xnssec8, mcdagg2$xnssec5, mcdagg2$xnssec3,
                  mcdagg2$xsex, mcdagg2$xtenure, mcdagg2$xyar,
                  mcdagg2$xeth)
# generate tables showing crosstabs with having a degree
# and chi square and cramer's v
m <- length(varray)
for (i in 1:m) {
  xtab <- wtd.table(varray[,i], 
                    mcdagg2$xdegree, 
                    weights=mcdagg2$xcount)
  print("Table ")
  print(xtab)
  chisq.test(xtab)
  cramer.v(xtab)
}

xm1 <- glm(mcdagg2$xdegree~mcdagg2$xsex + 
             mcdagg2$xage5 + mcdagg2$xnssec8 + 
             mcdagg2$xtenure,
             family=binomial)
# uncomment next line if you want to save model statistics
r1fit <- nagelkerke(xm1)

#sink("r1fit.txt")
print(r1fit$Pseudo.R.squared.for.model.vs.null)
print(r1fit$Likelihood.ratio.test)
# uncomment next line if you have saved model statistics
#sink()

xm1or <- odds.ratio(xm1)
# extract results
xm1names = c("Intercept", "Male", 
             "30-34", "35-39", "40-44", "45-49",
             "50-54", "55-59", "60-64", "65-69",
             "70-74", "75 or over",
             "Higher professional occupations",
             "Lower managerial, administrative and professional occupations",
             "Intermediate occupations",
             "Small employers and own account workers",
             "Lower supervisory and technical occupations",
             "Semi-routine occupations",
             "Routine occupations",
             "Never worked or long-term unemployed",
             "Not classified", 
             "Owned with a mortgage or shared ownership",
             "Social rented",
             "Private rented")
m <- length(xm1$coefficients)
for (i in 1:m) {
  r1name <- xm1names
  r1or <- xm1or$OR
  r1lci <- xm1or$`2.5 %`
  r1uci <- xm1or$`97.5 %`
  r1p <- xm1or$p
}
r1output <- data.frame(r1name,r1or,r1lci,r1uci,r1p)
write.csv(r1output,file="reg1or.csv")
############################################################
#   Model 2                                                #
############################################################

xm2 <- glm(mcdagg2$xdegree~mcdagg2$xsex + 
             mcdagg2$xage5 + mcdagg2$xnssec8 + 
             mcdagg2$xdisability + mcdagg2$xmarstat +
             mcdagg2$xeth + mcdagg2$xyar +
             mcdagg2$xtenure,
           family=binomial)
r2fit <- nagelkerke(xm2)

# uncomment next line if you want to save model statistics
#sink("r2fit.txt")
print(r2fit$Pseudo.R.squared.for.model.vs.null)
print(r2fit$Likelihood.ratio.test)
# uncomment next line if you have saved model statistics
#sink()
xm2or <- odds.ratio(xm2)
# extract results
xm2names = c("Intercept", "Male", 
             "30-34", "35-39", "40-44", "45-49",
             "50-54", "55-59", "60-64", "65-69",
             "70-74", "75 or over",
             "Higher professional occupations",
             "Lower managerial, administrative and professional occupations",
             "Intermediate occupations",
             "Small employers and own account workers",
             "Lower supervisory and technical occupations",
             "Semi-routine occupations",
             "Routine occupations",
             "Never worked or long-term unemployed",
             "Not classified", 
             "A little",
             "A lot",
             "Married or civil partnership",
             "Separated",
             "Widowed",
             "White Irish",
             "White other",
             "Mixed (white and black African or Caribbean)",
             "Mixed (white and Asian or other)",
             "Indian",
             "Pakistani",
             "Bangladeshi",
             "Chinese",
             "Asian other",
             "Black African",
             "Black Caribbean",	
             "Other",
             "before 1971",
             "1971-1980",
             "1981-1990",
             "1991-2000",
             "2001-2011",
             "Owned with a mortgage or shared ownership",
             "Social rented",
             "Private rented")
m <- length(xm2$coefficients)
for (i in 1:m) {
  r2name <- xm2names
  r2or <- xm2or$OR
  r2lci <- xm2or$`2.5 %`
  r2uci <- xm2or$`97.5 %`
  r2p <- xm2or$p
}
r2output <- data.frame(r2name,r2or,r2lci,r2uci,r2p)
write.csv(r2output,file="reg2or.csv")

