# Bank Credit Card Default Prediction


#1)Read data from excel

dflr=read.csv(file.choose())
dflr


#2)Data cleaning

str(dflr)
summary(dflr)

dflr$Customer.ID=NULL
dflr$Gender=as.factor(dflr$Gender)
dflr$Marital=as.factor(dflr$Marital)
dflr$Academic_Qualification=as.factor(dflr$Academic_Qualification)
dflr$Default_Payment=as.factor(dflr$Default_Payment)
dflr$Repayment_Status_Jan=as.factor(dflr$Repayment_Status_Jan)
dflr$Repayment_Status_Feb=as.factor(dflr$Repayment_Status_Feb)
dflr$Repayment_Status_March=as.factor(dflr$Repayment_Status_March)
dflr$Repayment_Status_April=as.factor(dflr$Repayment_Status_April)
dflr$Repayment_Status_May=as.factor(dflr$Repayment_Status_May)
dflr$Repayment_Status_June=as.factor(dflr$Repayment_Status_June)

dflr

#since we want to predict defaulters i.e =1 we have to change the Default_Payment levels to "1" and "0"
#$ Default_Payment       : Factor w/ 2 levels "0","1": 2 2 1 1 1 1 1 1 1 1 ...

dflr$Default_Payment=factor(dflr$Default_Payment,levels = c('1','0'))
str(dflr)


#3)Data visalization

#histogram

dev.new()
par(mfrow=c(3,2))
hist(dflr$Previous_Payment_Jan,main = "January",col = 'black',border = 'red')
hist(dflr$Previous_Payment_Feb,main = "February",col = 'black',border = 'red')
hist(dflr$Previous_Payment_March,main = "March",col = 'black',border = 'red')
hist(dflr$Previous_Payment_April,main = "April",col = 'black',border = 'red')
hist(dflr$Previous_Payment_May,main = "May",col = 'black',border = 'red')
hist(dflr$Previous_Payment_June,main = "June",col = 'black',border = 'red')


#boxplot    syntax == (numeric~factor)  always

dev.new()
boxplot(dflr$Credit_Amount~dflr$Default_Payment,col='black',border='blue')

dev.new()
boxplot(dflr$Credit_Amount~dflr$Repayment_Status_Jan,col='black',border='blue')

#scatter plot for relationship (x and y both should be numeric)
#ggplot

library(ggplot2)

gg1=ggplot(dflr,aes(x=dflr$Age_Years,y=dflr$Credit_Amount,col=dflr$Default_Payment))
dev.new()
gg1+geom_point()

table(dflr$Default_Payment)


#split the data into training and testing
#trn(70%) and tst(30%)

set.seed(123)

rnum=sample(nrow(dflr),nrow(dflr)*0.7)

head(rnum)

nrow(dflr)

trn=dflr[rnum,]
tst=dflr[-rnum,]

## use glm for logistical model 

dflrlog=glm(Default_Payment~.,data = trn,family = "binomial")

#predict on tst data and add new column in tst data
  

tst$predProb=predict(dflrlog,tst,type = "response")    #predicts chances of being 1

#type === respose will predict probabilities

tst

#convert probs into 1 or 0 bu threshold of 0.50

tst$pred=ifelse(tst$predProb>0.5,'1','0')   #if probability is more than 0.5 convert into 1 or else if less than 0.5 convert into 0

#check str of new column 'pred'

str(tst$pred)

#convert chr into favtor with levels 1 and 0

tst$pred=factor(tst$pred,levels = c('1','0'))
str(tst$pred)

#to find accuracy of prediction we use 'caret' package 'confusionMatrix'
library(caret)
library(caret)

confusionMatrix(tst$pred,tst$Default_Payment)   #requires predicted value and actual value
#this model failed as accuracy is onl7 0.173 (17%)


#cross validation model

ctrl=trainControl(method = "repeatedcv",
                  number = 10,savePredictions = TRUE)

logcv=train(Default_Payment~.,data = trn,
            method="glm", family="binomial",
            trControl=ctrl)

logcv

#remove new created columns in tst file

tst$pred=NULL
tst$predProb=NULL

# predict prob, convert to pred by 0.5 treshold
# confusionMatrix for accuracy



tst$predProb=predict(logcv,tst,type = "prob") 
tst$pred=ifelse(tst$predProb>0.5,'1','0') 

tst$pred=factor(tst$pred[1:9000],levels = c('1','0'))
str(tst$pred)

confusionMatrix(tst$pred,tst$Default_Payment)   #requires predicted value and actual value

#conclusion: this is the better model as it gives 0.82(82%) accuracy

  



























































































