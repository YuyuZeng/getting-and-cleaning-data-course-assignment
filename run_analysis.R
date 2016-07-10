library(reshape2)
filename <- "dataset.zip"

## Download the dataset
if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, filename, method = "curl")
}

## Unzip the dataset
if (!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

## Laod activityLabels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

## Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Extract only the measurements on the mean and standard deviation
featuresChosen <- grep(".*mean.*|.*std.*", features[,2])
featuresChosen.names <- features[featuresChosen,2]
featuresChosen.names <- gsub('-mean', 'Mean', featuresChosen.names)
featuresChosen.names <- gsub('-std', 'Std', featuresChosen.names)
featuresChosen.names <- gsub('[-()]', '', featuresChosen.names)

## Load the datasets
trainFeaturesChosen <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresChosen]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData <- cbind(trainSubjects, trainActivities, trainFeaturesChosen)

testFeaturesChosen <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresChosen]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSubjects, testActivities, testFeaturesChosen)

# merge datasets and add labels
allData <- rbind(trainData, testData)
colnames(allData) <- c("subject", "activity", featuresChosen.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

# label the data set with descriptive variable names.
colnames(allData)<-gsub("^t", "time", colnames(allData))
colnames(allData)<-gsub("^f", "frequency", colnames(allData))
colnames(allData)<-gsub("Acc", "Accelerometer", colnames(allData))
colnames(allData)<-gsub("Gyro", "Gyroscope", colnames(allData))
colnames(allData)<-gsub("Mag", "Magnitude", colnames(allData))
colnames(allData)<-gsub("BodyBody", "Body", colnames(allData))

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# export data into text file
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)