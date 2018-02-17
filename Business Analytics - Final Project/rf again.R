# working out 100% success rate
set.seed(635)
intrain <- createDataPartition(dv$classe,p=0.7, list=FALSE)
training_score <- dv[intrain,]
testing_score <- dv[-intrain,]
modelRF <- train(classe~., data=training_score, method="rf", prox=TRUE)
# extra stuff
target <- dv$classe
train_target <- training_score$classe
test_target <- testing_score$classe
training_score <- training_score[,-which(colnames(training_score)=="classe")]
test_score <- testing_score[,-which(colnames(testing_score)=="classe")]
