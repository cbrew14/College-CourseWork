#Read-In Code
setwd("")
help = read.csv("help.csv")


# cesd stats
library(e1071)
cesd = help$cesd
mean = mean(cesd)
median = median(cesd)
minimum = min(cesd)
quartile_1 = 25
quartile_3 = 41
max = max(cesd)
summary = summary(cesd)
kurtosis = kurtosis(cesd)
range_cesd = range(cesd)
range = "1-60"
standard_deviation = sd(cesd)
variance = var(cesd)
skewness = skewness(cesd)
missing_values = sum(is.na(cesd))
#create data frame of the values
stats_cesd = data.frame(mean, median, range, standard_deviation, 
                        variance, minimum, quartile_1, quartile_3,
                        max, skewness, kurtosis, missing_values)



#Create Histogram
hist(cesd)


#Bivariate Relationships
MCS = help$mcs
PCS = help$pcs
cor_cesd_mcs = cor(cesd,MCS)
cor_cesd_pcs = cor(cesd,PCS)
cor_mcs_pcs = cor(MCS,PCS)


#Contingency Tables
library(gmodels)
Gender = ifelse(help$female==1, "female", "male")
House_Status = ifelse(help$homeless==1, "homeless", "housed")
test = xtabs(~Gender + House_Status)
#I tried fisher.test, but it only gave me one odds ratio
fisher.test(test)
fisher.test(Gender, House_Status)
#Manual Attempt
Odds_Female_Homeless = 40/169
Odds_Male_Homeless = 169/40
Odds_Female_Housed = 67/177 
Odds_Male_Housed = 177/67
#The odds of a homeless person being female are 0.625 times less likely than a housed person being female
OR_Female = Odds_Female_Homeless/Odds_Female_Housed
#The odds of homeless person being male are 1.599 times more likely than a housed person being a male
OR_Male = Odds_Male_Homeless/Odds_Male_Housed
#chi-squared
chisq.test(test)


#Two Sample Tests of Continuous Variables
library(coin)
Age = help$age
Gender_num = as.numeric(help$female)
g_fact = as.factor(Gender_num)
wil = wilcox.test(Gender_num,Age)
ks = ks.test(Gender_num,Age)
median_test(Age~g_fact)