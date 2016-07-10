# CodeBook
## General procedure description for the R script:
1. Download the zip file from the online source.
2. Load activityLabels and features.
3. Load the training and test sets and keep only the measurements on the mean and standard deviation.
4. Merge the training and test sets together (add labels).
5. Converts the activity and subject columns into factors.
6. Using descriptive activity names to name the activities in the data set.
7. Labels the data set with descriptive variable names.
8. Creates a tidy dataset that consists of the mean value of each variable for each subject and activity pair.
9. Use the write.table command to export the tidy dataset into tidy.txt.

## Variables description:
activityLabels: levels and labels of activities
features: all features
featuresChosen: the measurements on the mean and standard deviation
trainFeaturesChosen: train data set for featuresChosen
trainActivities: train data set for activities
trainSubjects: train data set for subjects
trainData: combined activities, subjects and featuresChosen for the train data set
testFeatureChosen: test data set for featuresChosen
testActivities: test data set for activities
testSubjects: test data set for subjects
testData: combined activities, subjects and featuresChosen for the test data set
allData: combined data sets of train and test data set
