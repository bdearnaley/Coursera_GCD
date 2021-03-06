wd<-"C:\\Users\\GSS\\Documents\\Coursera\\GetCleanData\\Project\\UCI HAR Dataset"
setwd(wd)
train_dest<-paste(getwd(),"/train",sep="",COLLAPSE=NULL)
test_dest<-paste(getwd(),"/test",sep="",COLLAPSE=NULL)

activity_labels <-read.table("activity_labels.txt")
features <- read.table("features.txt")

##Load the Train data
setwd(train_dest)
subject_train<-read.table("subject_train.txt")
X_train<-read.table("X_train.txt")
Y_train<-read.table("Y_train.txt")

##Load the Test data
setwd(test_dest)
subject_test<-read.table("subject_test.txt")
X_test<-read.table("X_test.txt")
Y_test<-read.table("y_test.txt")

##Add a Subject_ID
colnames(subject_test)<-"Subject_ID"
colnames(subject_train)<-"Subject_ID"

##Adding the Activity labels
## 1 WALKING
## 2 WALKING_UPSTAIRS
## 3 WALKING_DOWNSTAIRS
## 4 SITTING
## 5 STANDING
## 6 LAYING
colnames(Y_train)<-"Activity_ID"
Y_train$Activity=""
Y_train$Activity[Y_train$Activity_ID=="1"]<-"WALKING"
Y_train$Activity[Y_train$Activity_ID=="2"]<-"WALKING_UPSTAIRS"
Y_train$Activity[Y_train$Activity_ID=="3"]<-"WALKING_DOWNSTAIRS"
Y_train$Activity[Y_train$Activity_ID=="4"]<-"SITTING"
Y_train$Activity[Y_train$Activity_ID=="5"]<-"STANDING"
Y_train$Activity[Y_train$Activity_ID=="6"]<-"LAYING"

colnames(Y_test)<-"Activity_ID"
Y_test$Activity=""
Y_test$Activity[Y_test$Activity_ID=="1"]<-"WALKING"
Y_test$Activity[Y_test$Activity_ID=="2"]<-"WALKING_UPSTAIRS"
Y_test$Activity[Y_test$Activity_ID=="3"]<-"WALKING_DOWNSTAIRS"
Y_test$Activity[Y_test$Activity_ID=="4"]<-"SITTING"
Y_test$Activity[Y_test$Activity_ID=="5"]<-"STANDING"
Y_test$Activity[Y_test$Activity_ID=="6"]<-"LAYING"

##Add the feature labels
colnames(X_test)<-features[,2]
colnames(X_train)<-features[,2]

##Extract only the Mean or StdDev values from the features
cols<-grep('std|mean',features$V2,ignore.case=TRUE)
X_test<-X_test[cols]
X_train<-X_train[cols]

##Combine the Test data
test_data<-cbind(subject_test,Y_test,X_test)

##Combine the Train data
train_data<-cbind(subject_train,Y_train,X_train)

##Combine the Test and Train data
tidy_data<-rbind(train_data,test_data)

