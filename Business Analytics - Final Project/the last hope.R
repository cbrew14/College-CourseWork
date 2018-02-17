hope <- dv
# The Jedi's Last Hope
hope_inTrain <- createDataPartition(y=hope$classe, p=0.75, list=FALSE, times = 1)
hope_train <- hope[hope_inTrain,]
hope_test <- hope[-hope_inTrain]
dim(hope_train)
hope_train = as.data.frame(hope_train)

#Hope Fading
objControl <- trainControl(method = 'cv', number=3, returnResamp = 'none'
                           ,summaryFunction = twoClassSummary, classProbs = TRUE)
set.seed(32343)
hope_modelfit <- (classe~.,data=hope_train)