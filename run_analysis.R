# Download and unzip data
if (!file.exists("data")) {
        dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/dataset.zip",mode ="wb")
unzip("./data/dataset.zip")

#Path to data files.
path <- "./UCI HAR Dataset/"
path_train <- paste(path,"train/",sep="")
path_test <- paste(path,"test/",sep="")

features_file <- paste(path,"features.txt",sep="")
activity_file <- paste(path,"activity_labels.txt",sep="")
xtrain_file <- paste(path_train,"X_train.txt",sep="")
ytrain_file <- paste(path_train,"Y_train.txt",sep="")
subjecttrain_file <- paste(path_train,"subject_train.txt",sep="")
xtest_file <- paste(path_test,"X_test.txt",sep="")
ytest_file <- paste(path_test,"Y_test.txt",sep="")
subjecttest_file <- paste(path_test,"subject_test.txt",sep="")

#Read files.
features <- as.character(read.table(features_file)[,2])
activity <- read.table(activity_file)
xtrain <- read.table(xtrain_file,col.names = features)
ytrain <- read.table(ytrain_file,col.names = "activity")
subjecttrain <- read.table(subjecttrain_file, col.names = "subject")
xtest <- read.table(xtest_file,col.names = features)
ytest <- read.table(ytest_file,col.names = "activity")
subjecttest <- read.table(subjecttest_file, col.names = "subject")
labels <- read.table(activity_file)

#Merge train and test data sets.
test <- cbind(subjecttest, ytest, xtest)
colnames(test) <- c(c("subject", "activity"), features)
train <- cbind(subjecttrain, ytrain, xtrain)
colnames(train) <- c(c("subject", "activity"), features)
merge_data <- rbind(test, train)

#Measurements on the mean and standard deviation for each measurement.
mean_sd <- grep("-(mean|std)\\(\\)", colnames(merge_data))
meansd_df <- cbind(merge_data[,1:2],merge_data[,mean_sd])

#Descriptive activity names to name the activities in the data set.
labels[,2] <- as.character(labels[,2])
meansd_df$activity <- as.character(meansd_df$activity)
for (i in 1:6){
        meansd_df$activity[meansd_df$activity == i] <- labels[i,2]
}

#Labels the data set with descriptive names.
colnames(meansd_df)<-gsub("Acc", "Accelerometer", colnames(meansd_df))
colnames(meansd_df)<-gsub("Gyro", "Gyroscope", colnames(meansd_df))
colnames(meansd_df)<-gsub("BodyBody", "Body", colnames(meansd_df))
colnames(meansd_df)<-gsub("Mag", "Magnitude", colnames(meansd_df))
colnames(meansd_df)<-gsub("^t", "Time", colnames(meansd_df))
colnames(meansd_df)<-gsub("^f", "Frequency", colnames(meansd_df))

#Tidy data set with the average of each variable for each activity and each subject
library(data.table)
meansd_df$subject <- as.factor(meansd_df$subject)
meansd_df <- data.table(meansd_df)
tidyData <- aggregate(. ~subject + activity, meansd_df, mean)
tidyData <- tidyData[order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = "tidy_data.txt", row.names = FALSE)


