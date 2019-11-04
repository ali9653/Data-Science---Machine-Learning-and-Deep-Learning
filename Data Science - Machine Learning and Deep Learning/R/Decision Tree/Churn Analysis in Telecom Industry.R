#Churn Analysis in Telecom Industry


#import data
dfdt=read.csv(file.choose())
dfdt
str(dfdt)

#data cleaning

summary(dfdt)
str(dfdt)

dfdt$customerID=NULL
dfdt$SeniorCitizen=as.integer(dfdt$SeniorCitizen)

dfdt$SeniorCitizen=as.factor(dfdt$SeniorCitizen)
dfdt$Churn=factor(dfdt$Churn,levels = c('Yes','No'))



str(dfdt)


library(plyr)


dfdt$OnlineBackup=revalue(dfdt$OnlineBackup,
                          c("No internet service"="No"))

dfdt$OnlineMovies=revalue(dfdt$OnlineMovies,c("No internet service"="No"))


dfdt$OnlineSecurity=revalue(dfdt$OnlineSecurity,c("No internet service"="No"))


dfdt$TechnicalHelp=revalue(dfdt$TechnicalHelp,c("No internet service"="No"))

dfdt$DeviceProtectionService=revalue(dfdt$DeviceProtectionService,c("No internet service"="No"))

dfdt$MultipleConnections=revalue(dfdt$MultipleConnections,c("No phone service"="No"))

dfdt$OnlineTV=revalue(dfdt$OnlineTV,c("No internet service"="No"))

dfdt$OnlineSecurity=revalue(dfdt$OnlineSecurity,c("No internet service"="No"))


str(dfdt)

#eda


library(gmodels)

CrossTable(dfdt$Churn,dfdt$gender,
           prop.chisq = FALSE,
           prop.c = FALSE,
           prop.t = FALSE,
           chisq = TRUE)       #chisq true because we dont want to see the other values in the output

#data visualization

dev.new()
boxplot(dfdt$tenure~dfdt$Churn)



#split data into training and testing

set.seed(123)

rnum=sample(nrow(dfdt),nrow(dfdt)*0.7)

head(rnum)

nrow(dfdt)

trn=dfdt[rnum,]
tst=dfdt[-rnum,]

#build tree using rpart

library(rpart.plot)
library(rpart)

dtree1=rpart(Churn~.,data = trn,method = 'class')
dtree1


#tree plot

library(rattle)
install.packages("rattle")

dev.new()
fancyRpartPlot(dtree1,type = 3)

#predict and confusion matrix

tst$predProb=predict(dtree1,newdata = tst)
str(trn$Churn)

tst$pred=ifelse(tst$predProb>0.5,'Yes','No')
str(tst$pred)

tst$pred=factor(tst$pred[1:3701],levels = c('Yes','No'))


library(caret)

confusionMatrix(tst$pred,tst$Churn)


#next option randomForest

library(randomForest)

rf=randomForest(Churn~.,data = trn)
print(rf)

tst$rfpredprob=predict(rf,newdata = tst,type = 'prob')
rfpred=predict(rf,newdata = tst)


confusionMatrix(rfpred,tst$Churn)


#ROC curve

library(pROC)
install.packages("pROC")

dev.new(1)
plot.roc(tst$Churn,tst$predProb[1:3701],
         print.auc=T,main = "Decision Tree")

dev.new(2)
plot.roc(tst$Churn,tst$rfpredprob[1:3701],
         print.auc=T,main="Random Forest")

#we conclude that rainforest model is doing a better job than decision tree






















































































































