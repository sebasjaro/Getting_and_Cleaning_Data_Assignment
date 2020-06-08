# CodeBook

Author: Sebastián Jaroszewicz

# Variables

**subject**
Factor variable: 30 levels

**activity**
Factor variable: 6 levels


The dataset has the following main types of measurementes:

* tBodyAcc
* tGravityAcc
* tBodyAccJerk
* tBodyGyro
* tBodyGyroJerk
* tBodyAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc
* fBodyAccJerk
* fBodyGyro
* fBodyAccMag
* fBodyBodyAccJerkMag
* fBodyBodyGyroMag
* fBodyBodyGyroJerkMag.

Each main data type XXX is divided into the following measurements

* XXX-mean()-X
* XXX-mean()-Y
* XXX-mean()-Z
* XXX-std()-X
* XXX-std()-Y
* XXX-std()-Z

# Script
The script run_analysis.R performs the following actions

* Download and unzip data.
* Reads files.
* Merge train and test data sets.
* Extract only measurements on the mean and standard deviation for each measurement.
* Sets dscriptive names for the activities in the data set.
* Labels the data set with descriptive names.
* Saves a tidy data set with the average of each variable for each activity and each subject.
