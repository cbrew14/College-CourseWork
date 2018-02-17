#open csv files
test <- read.csv('machine-testing.csv')
train <- read.csv('machine-training.csv')

# Explore the dataset and determine which of the predictors are worth keeping in the analysis.
# Eliminate NA columns and create data set to test
ds <- train[ , colSums(is.na(train)) < 9811]
# Convert classe into dichotomous outcome
ds$classe <- ifelse(ds$classe=='A', 1, 0)
"# Determine and eliminate variables where majority of obs are blank
sum(ds$kurtosis_picth_arm =="")
ds$kurtosis_picth_arm <- NULL
ifelse(sapply(ds, class) == "numeric",
       if((colSums(ds)=="")<9811) x+1 , 
       NA)"
#long method
dv <- ds
summary(dv)
  #individually remove all empty variables
dv$kurtosis_yaw_belt<-NULL
dv$kurtosis_roll_belt<-NULL
dv$skewness_roll_belt<-NULL
dv$skewness_roll_belt<-NULL
dv$yaw_belt<-NULL
dv$max_yaw_belt<-NULL
dv$min_yaw_belt<-NULL
dv$amplitude_yaw_belt<-NULL
dv$kurtosis_roll_arm<-NULL
dv$kurtosis_picth_arm<-NULL
dv$kurtosis_yaw_arm<-NULL
dv$skewness_roll_arm<-NULL
dv$skewness_pitch_arm<-NULL
dv$skewness_yaw_arm<-NULL
dv$kurtosis_roll_dumbbell<-NULL
dv$kurtosis_picth_dumbbell<-NULL
dv$kurtosis_yaw_dumbbell<-NULL
dv$skewness_roll_dumbbell<-NULL
dv$skewness_pitch_dumbbell<-NULL
dv$skewness_yaw_dumbbell<-NULL
dv$max_yaw_dumbbell<-NULL
dv$min_yaw_dumbbell<-NULL
dv$amplitude_yaw_dumbbell<-NULL
dv$kurtosis_roll_forearm<-NULL
dv$kurtosis_picth_forearm<-NULL
dv$kurtosis_yaw_forearm<-NULL
dv$skewness_roll_forearm<-NULL
dv$skewness_pitch_forearm<-NULL
dv$skewness_yaw_forearm<-NULL
dv$max_yaw_forearm<-NULL
dv$min_yaw_forearm<-NULL
dv$amplitude_yaw_forearm<-NULL
 #missed variables
dv$kurtosis_picth_belt<-NULL
dv$skewness_roll_belt.1<-NULL
dv$skewness_yaw_belt<-NULL

#determine if non-variable/integer variables should stay
theory = dv
table(theory$classe[theory$user_name=="adelmo"])
table(theory$classe[theory$user_name=="carlitos"])
table(theory$classe[theory$user_name=="charles"])
table(theory$classe[theory$user_name=="eurico"])
table(theory$classe[theory$user_name=="jeremy"])
table(theory$classe[theory$user_name=="pedro"])
theory$raw_timestamp_part_1 <-NULL
theory$user_name<-NULL
theory$raw_timestamp_part_2<-NULL
theory$cvtd_timestamp<-NULL
theory$new_window<-NULL
theory$num_window<-NULL
theory$x<-NULL
#Set up doSNOW package for multi-core training

#Train a Random Forest
df <- dv[ , sapply(dv, class) == 'numeric']
di <- dv[ , sapply(dv, class) == 'integer']
rf.label <- as.factor(theory$classe)
rf.train.1 <- data.frame(theory$roll_belt, theory$pitch_belt)
rf.train.num <- df
rf.train.int <- di
rf.train.all <- dv
  
   # 10 k cross validation 10 times
set.seed(2348)
cv.10.folds <- createMultiFolds(rf.label, k = 10, times = 10)
# Check strtification
table(rf.label)
rf.label
5580/14042
0.3973793
table(rf.label[cv.10.folds[[33]]])
5022/12638
0.397373

# Set seed for reproducibility and train
set.seed(34324)
rf.int.cv.1 <- train(x = rf.train.int, y = rf.label, method = "rf", tuneLength = 3,
                     ntree = 1000, trControl = ctrl.1)
#Shutdown cluster

