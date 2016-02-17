#KNN - Predicting flower types

#using iris dataset, can review using head(iris) or summary(iris)
#can also create scatterplots with the ggvis package to see data more closely
library(ggvis)
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

#A quick look at the Species attribute through tells you that the division of the species of flowers is 50-50-50:
table(iris$Species) 

#knn is inside package class
library(class)

#create training & test set
set.seed(1234)
#sample (with replacement - 67%, 33%)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iris.training <- iris[ind==1, 1:4]
iris.test <- iris[ind==2, 1:4]

iris.training
#use only sepal.length, sepal.width, petal.length, petal.width for input - predict on Species
iris.trainLabels <- iris[ind==1, 5]
iris.testLabels <- iris[ind==2, 5]

#build the classifier - knn() uses Euclidean distance. Can review by calling iris_pred
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=1)

data1 <- c(5.6,3.4,1.6,0.3,6.6,3.4,4.3,1.6,7.6,3.4,3.6,1.3,6.2,3.4,5.4,2.3)
m <- matrix(data = data1,nrow = 4, ncol = 4, byrow = TRUE)
iris.test1 <- data.frame(m,check.rows = TRUE)
colnames(iris.test1) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")
iris_pred1 <- knn(train = iris.training, test = iris.test1, cl = iris.trainLabels, k=1)

#you can also use package models to create a cross tabulation 
library(gmodels)
CrossTable(x = iris.testLabels, y = iris_pred1, prop.chisq=FALSE)

library(RWeka)
iris.weka <-J48(Species~., data=iris)
summary(iris.weka)

predict(iris.weka,iris.test1)
