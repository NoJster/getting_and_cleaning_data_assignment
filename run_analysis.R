library(dplyr)

## download and unzip data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip")

## read in the list of features
features <- read.table("UCI HAR Dataset\\features.txt", header = FALSE, col.names = c("id", "name"))

## read in the activity labels
activities <- read.table("UCI HAR Dataset\\activity_labels.txt", header = FALSE, col.names = c("id", "name"), stringsAsFactors = FALSE)

## read test and training sets
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
names(x_test) <- features$name
y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE, col.names = "id")
y_test <- merge(y_test, activities, by.x = "id", by.y = "id")[2]
names(y_test) <- "activity"
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE, col.names = "subject")

x_train <- read.table("UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
names(x_train) <- features$name
y_train <- read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE, col.names = "id")
y_train <- merge(y_train, activities, by.x = "id", by.y = "id")[2]
names(y_train) <- "activity"
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE, col.names = "subject")

## cbind activity column to the beginning of the tests
test <- cbind(cbind(y_test, subject_test), x_test)
train <- cbind(cbind(y_train, subject_train), x_train)

## rbind test and train to obtain one huge dataset
data <- rbind(test, train)

## extract mean() and std() from data
interesting_cols <- sort(c(grep("std()", features$name), grep("mean", features$name)))+2 
data_slice <- data[,c(1,2,interesting_cols)]

## build tidy frame
tidy_frame <- group_by(data_slice, activity, subject) %>% summarize_all(funs(mean))

## write tidy frame to disk
write.table(x = tidy_frame, file = "tidy_frame.txt", row.name = FALSE)