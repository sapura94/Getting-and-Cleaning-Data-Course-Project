#Use dplyr package

#trainX, trainY, subjectTrain have the data from training datasets.

#testX, testY, subjectTest have the data from test datasets.

#activityLabels is a dataframe from activity_labels.txt file.

#features is a dataframe from features.txt file.

#mergetrain is a result of merging trainY, subjectTrain and trainX

#mergetest is a result of merging testX, subjectTest and trainY

#oneset is a result of merging mergetrain and  mergetest together.

#meandstd_set is a dataset which has only mean and standard deviation

#TidySet2 is the second independent tidy data set with the average of each variable for each activity and each subject
