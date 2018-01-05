---
title: "Codebook for \"Getting and Cleaning Data Course Project\""
author: "Nils o. Janus"
date: "January 4, 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Steps Involved
To complete the assignment, the steps outlined in this document are performed

### Download and Unzip Data
We download the raw data file via the URL provided in the assignment and unzip it as follows:
```{r, eval=FALSE}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip")
```

### Read in Data
In a first step, we read in the raw data of the features and activities provided as well as both test and training data like so (training set is processed identically):
```{r, eval=FALSE}
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
names(x_test) <- features$name
y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE, col.names = "id")
y_test <- merge(y_test, activities, by.x = "id", by.y = "id")[2]
names(y_test) <- "activity"
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE, col.names = "subject")
```

### Update Data
We then add subjects to the respective data sets (i.e. an additional column) and then glue the two data sets together:
```{r, eval=FALSE}
test <- cbind(cbind(y_test, subject_test), x_test)
train <- cbind(cbind(y_train, subject_train), x_train)
data <- rbind(test, train)
```

### Slice Data
For slicing our data, we are gathering the interesting columns, i.e. those relating to either a mean of standard deviation calculation. Note that while columns 557-563 hold variables calculating angles between coordinated and mean values, we chose to exclude them from our list here. 

Once interesting columns are extracted, we build our sliced data set:
```{r, eval=FALSE}
interesting_cols <- sort(c(grep("std()", features$name), grep("mean", features$name)))+2 
data_slice <- data[,c(1,2,interesting_cols)]
```

### Tidy Data
In order to generate a tidy resulting data frame, we first group by activity and subject to finally summarize these values by applying the mean function to each pair of activity/subject.

```{r, eval=FALSE}
tidy_frame <- group_by(data_slice, activity, subject) %>% summarize_all(funs(mean))
```

### Write Data
Finally, data is written back to disk:

```{r, eval=FALSE}
write.table(x = tidy_frame, file = "tidy_frame.txt", row.name = FALSE)
```

## Variables description  

The following table lists, describes and classifies the data type of all variables in the tidy dataset:

| **column name** | **description** | **data type** |
|-----------------|-----------------|---------------|
| activity        | activity performed during the measurement | categorical |
| subject         | subject performing the activity | categorical |
| tBodyAcc-mean()-X |mean value of tBodyAcc-mean()-X |continuous|
| tBodyAcc-mean()-Y |mean value of tBodyAcc-mean()-Y |continuous|
| tBodyAcc-mean()-Z |mean value of tBodyAcc-mean()-Z |continuous|
| tBodyAcc-std()-X |mean value of tBodyAcc-std()-X |continuous|
| tBodyAcc-std()-Y |mean value of tBodyAcc-std()-Y |continuous|
| tBodyAcc-std()-Z |mean value of tBodyAcc-std()-Z |continuous|
| tGravityAcc-mean()-X |mean value of tGravityAcc-mean()-X |continuous|
| tGravityAcc-mean()-Y |mean value of tGravityAcc-mean()-Y |continuous|
| tGravityAcc-mean()-Z |mean value of tGravityAcc-mean()-Z |continuous|
| tGravityAcc-std()-X |mean value of tGravityAcc-std()-X |continuous|
| tGravityAcc-std()-Y |mean value of tGravityAcc-std()-Y |continuous|
| tGravityAcc-std()-Z |mean value of tGravityAcc-std()-Z |continuous|
| tBodyAccJerk-mean()-X |mean value of tBodyAccJerk-mean()-X |continuous|
| tBodyAccJerk-mean()-Y |mean value of tBodyAccJerk-mean()-Y |continuous|
| tBodyAccJerk-mean()-Z |mean value of tBodyAccJerk-mean()-Z |continuous|
| tBodyAccJerk-std()-X |mean value of tBodyAccJerk-std()-X |continuous|
| tBodyAccJerk-std()-Y |mean value of tBodyAccJerk-std()-Y |continuous|
| tBodyAccJerk-std()-Z |mean value of tBodyAccJerk-std()-Z |continuous|
| tBodyGyro-mean()-X |mean value of tBodyGyro-mean()-X |continuous|
| tBodyGyro-mean()-Y |mean value of tBodyGyro-mean()-Y |continuous|
| tBodyGyro-mean()-Z |mean value of tBodyGyro-mean()-Z |continuous|
| tBodyGyro-std()-X |mean value of tBodyGyro-std()-X |continuous|
| tBodyGyro-std()-Y |mean value of tBodyGyro-std()-Y |continuous|
| tBodyGyro-std()-Z |mean value of tBodyGyro-std()-Z |continuous|
| tBodyGyroJerk-mean()-X |mean value of tBodyGyroJerk-mean()-X |continuous|
| tBodyGyroJerk-mean()-Y |mean value of tBodyGyroJerk-mean()-Y |continuous|
| tBodyGyroJerk-mean()-Z |mean value of tBodyGyroJerk-mean()-Z |continuous|
| tBodyGyroJerk-std()-X |mean value of tBodyGyroJerk-std()-X |continuous|
| tBodyGyroJerk-std()-Y |mean value of tBodyGyroJerk-std()-Y |continuous|
| tBodyGyroJerk-std()-Z |mean value of tBodyGyroJerk-std()-Z |continuous|
| tBodyAccMag-mean() |mean value of tBodyAccMag-mean() |continuous|
| tBodyAccMag-std() |mean value of tBodyAccMag-std() |continuous|
| tGravityAccMag-mean() |mean value of tGravityAccMag-mean() |continuous|
| tGravityAccMag-std() |mean value of tGravityAccMag-std() |continuous|
| tBodyAccJerkMag-mean() |mean value of tBodyAccJerkMag-mean() |continuous|
| tBodyAccJerkMag-std() |mean value of tBodyAccJerkMag-std() |continuous|
| tBodyGyroMag-mean() |mean value of tBodyGyroMag-mean() |continuous|
| tBodyGyroMag-std() |mean value of tBodyGyroMag-std() |continuous|
| tBodyGyroJerkMag-mean() |mean value of tBodyGyroJerkMag-mean() |continuous|
| tBodyGyroJerkMag-std() |mean value of tBodyGyroJerkMag-std() |continuous|
| fBodyAcc-mean()-X |mean value of fBodyAcc-mean()-X |continuous|
| fBodyAcc-mean()-Y |mean value of fBodyAcc-mean()-Y |continuous|
| fBodyAcc-mean()-Z |mean value of fBodyAcc-mean()-Z |continuous|
| fBodyAcc-std()-X |mean value of fBodyAcc-std()-X |continuous|
| fBodyAcc-std()-Y |mean value of fBodyAcc-std()-Y |continuous|
| fBodyAcc-std()-Z |mean value of fBodyAcc-std()-Z |continuous|
| fBodyAcc-meanFreq()-X |mean value of fBodyAcc-meanFreq()-X |continuous|
| fBodyAcc-meanFreq()-Y |mean value of fBodyAcc-meanFreq()-Y |continuous|
| fBodyAcc-meanFreq()-Z |mean value of fBodyAcc-meanFreq()-Z |continuous|
| fBodyAccJerk-mean()-X |mean value of fBodyAccJerk-mean()-X |continuous|
| fBodyAccJerk-mean()-Y |mean value of fBodyAccJerk-mean()-Y |continuous|
| fBodyAccJerk-mean()-Z |mean value of fBodyAccJerk-mean()-Z |continuous|
| fBodyAccJerk-std()-X |mean value of fBodyAccJerk-std()-X |continuous|
| fBodyAccJerk-std()-Y |mean value of fBodyAccJerk-std()-Y |continuous|
| fBodyAccJerk-std()-Z |mean value of fBodyAccJerk-std()-Z |continuous|
| fBodyAccJerk-meanFreq()-X |mean value of fBodyAccJerk-meanFreq()-X |continuous|
| fBodyAccJerk-meanFreq()-Y |mean value of fBodyAccJerk-meanFreq()-Y |continuous|
| fBodyAccJerk-meanFreq()-Z |mean value of fBodyAccJerk-meanFreq()-Z |continuous|
| fBodyGyro-mean()-X |mean value of fBodyGyro-mean()-X |continuous|
| fBodyGyro-mean()-Y |mean value of fBodyGyro-mean()-Y |continuous|
| fBodyGyro-mean()-Z |mean value of fBodyGyro-mean()-Z |continuous|
| fBodyGyro-std()-X |mean value of fBodyGyro-std()-X |continuous|
| fBodyGyro-std()-Y |mean value of fBodyGyro-std()-Y |continuous|
| fBodyGyro-std()-Z |mean value of fBodyGyro-std()-Z |continuous|
| fBodyGyro-meanFreq()-X |mean value of fBodyGyro-meanFreq()-X |continuous|
| fBodyGyro-meanFreq()-Y |mean value of fBodyGyro-meanFreq()-Y |continuous|
| fBodyGyro-meanFreq()-Z |mean value of fBodyGyro-meanFreq()-Z |continuous|
| fBodyAccMag-mean() |mean value of fBodyAccMag-mean() |continuous|
| fBodyAccMag-std() |mean value of fBodyAccMag-std() |continuous|
| fBodyAccMag-meanFreq() |mean value of fBodyAccMag-meanFreq() |continuous|
| fBodyBodyAccJerkMag-mean() |mean value of fBodyBodyAccJerkMag-mean() |continuous|
| fBodyBodyAccJerkMag-std() |mean value of fBodyBodyAccJerkMag-std() |continuous|
| fBodyBodyAccJerkMag-meanFreq() |mean value of fBodyBodyAccJerkMag-meanFreq() |continuous|
| fBodyBodyGyroMag-mean() |mean value of fBodyBodyGyroMag-mean() |continuous|
| fBodyBodyGyroMag-std() |mean value of fBodyBodyGyroMag-std() |continuous|
| fBodyBodyGyroMag-meanFreq() |mean value of fBodyBodyGyroMag-meanFreq() |continuous|
| fBodyBodyGyroJerkMag-mean() |mean value of fBodyBodyGyroJerkMag-mean() |continuous|
| fBodyBodyGyroJerkMag-std() |mean value of fBodyBodyGyroJerkMag-std() |continuous|
| fBodyBodyGyroJerkMag-meanFreq() |mean value of fBodyBodyGyroJerkMag-meanFreq() |continuous|
