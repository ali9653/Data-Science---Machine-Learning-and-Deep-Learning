#linear discriminant analysis (LDA)

library(MASS)
library(car)

data(wine,package = 'rattle.data')
install.packages("rattle.data")

data("wine")


df=wine
str(df)

dev.new()
scatterplotMatrix(df[2:6])

#as per LDA all numeric data are near to normal with correlated variables
dev.new()
ggplot(df,aes(df$Alcohol,df$Malic,col=df$Type))+geom_point()
dev.new()
ggplot(df,aes(df$Ash,df$Alcalinity,col=df$Type))+geom_point()

#split data into training and testing

set.seed(123)

rnum=sample(nrow(df),nrow(df)*0.7)

head(rnum)

nrow(df)

trn=df[rnum,]
tst=df[-rnum,]

library(caret)

lda1=train(Type~.,data = trn,method="lda")
lda1

#prediction and accuracy

lda1.pred=predict(lda1,newdata = tst)

confusionMatrix(lda1.pred,tst$Type)

#conclusion : 100%accuracy model is very good


































































































































