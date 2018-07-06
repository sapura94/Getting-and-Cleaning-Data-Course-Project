#Peer-graded Assignment :Getting and Cleaning Data Course Project

getwd()
[1] "C:/Users/nor.sapura/Documents"

#load the package dplyr 
library(dplyr)

#download data
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="DataSamsung.zip")

#unzip file
unzip(zipfile="DataSamsung.zip", exdir="DS")

#read files
trainX<-read.table("./DS/UCI HAR Dataset/train/x_train.txt")
trainY<-read.table("./DS/UCI HAR Dataset/train/y_train.txt")
subjectTrain<-read.table("./DS/UCI HAR Dataset/train/subject_train.txt")

testX<-read.table("./DS/UCI HAR Dataset/test/x_test.txt")
testY<-read.table("./DS/UCI HAR Dataset/test/y_test.txt")
subjectTest<-read.table("./DS/UCI HAR Dataset/test/subject_test.txt")

features<-read.table("./DS/UCI HAR Dataset/features.txt")

activityLabels<-read.table("./DS/UCI HAR Dataset/activity_labels.txt")

#assign column names
colnames(trainX) <- features[,2] 
colnames(trainY) <-"activityId"
colnames(subjectTrain) <- "subjectId"

colnames(testX) <- features[,2] 
colnames(testY) <- "activityId"
colnames(subjectTest) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#merge all data in one set
mergetrain <- cbind(trainY, subjectTrain, trainX)
mergetest <- cbind(testY, subjectTest, testX)
oneset <- rbind(mergetrain, mergetest)

#extract mean and standard deviation
meanstd <- (grepl("activityId" , colNames) | 
+                  grepl("subjectId" , colNames) | 
+                  grepl("mean.." , colNames) | 
+                  grepl("std.." , colNames)
)

meanstd_set<- oneset[ , meanstd == TRUE]

#Use descriptive activity names to name the activities in the data set

ActivityNames<- as.factor(oneset$activityId)
SubjectNames<- as.factor(oneset$subjectId)

#labels the data set with descriptive variable names

names(oneset)
names(oneset)<-gsub("Acc", "Accelerometer", names(oneset))
names(oneset)<-gsub("Gyro", "Gyroscope", names(oneset))
names(oneset)<-gsub("BodyBody", "Body", names(oneset))
names(oneset)<-gsub("Mag", "Magnitude", names(oneset))
names(oneset)<-gsub("^t", "Time", names(oneset))
names(oneset)<-gsub("^f", "Frequency", names(oneset))
names(oneset)<-gsub("tBody", "TimeBody", names(oneset))
names(oneset)<-gsub("-mean()", "Mean", names(oneset), ignore.case = TRUE)
names(oneset)<-gsub("-std()", "STD", names(oneset), ignore.case = TRUE)
names(oneset)<-gsub("-freq()", "Frequency", names(oneset), ignore.case = TRUE)
names(oneset)<-gsub("angle", "Angle", names(oneset))
names(oneset)<-gsub("gravity", "Gravity", names(oneset))

#second independent tidy data set with the average of each variable for each activity and each subject
TidySet2 <- aggregate(. ~subjectId + activityId, oneset, mean)
TidySet2 <- TidySet2[order(TidySet2$subject, TidySet2$activity),]
write.table(TidySet2, file="tidydata.txt", row.name=FALSE)
