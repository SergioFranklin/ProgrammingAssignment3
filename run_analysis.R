wd_corrente <- getwd() 

setwd("C:/Users/Sergio Franklin/Desktop/Academia/6BigData/Curso_Data_Science/Unit3 Getting and Cleanning Data/ProgrammingAssignment3")

if (!file.exists("Project")) {
  dir.create("Project")
}

prjdataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(prjdataUrl, destfile= "./Project/getdata-projectfiles-UCI HAR Dataset.zip" )

##
## Merging the training and the test sets to create one data set
##
## Reading the test folder
subject_test <- read.table("./Project/UCI HAR Dataset/test/subject_test.txt", sep="")
X_test <- read.table("./Project/UCI HAR Dataset/test/X_test.txt", sep="")
y_test <- read.table("./Project/UCI HAR Dataset/test/y_test.txt", sep="")
## Reading the train folder
subject_train <- read.table("./Project/UCI HAR Dataset/train/subject_train.txt", sep="")
X_train <- read.table("./Project/UCI HAR Dataset/train/X_train.txt", sep="")
y_train <- read.table("./Project/UCI HAR Dataset/train/y_train.txt", sep="")
## Inspecting the data
str(subject_test); str(subject_train)
str(X_test); str(X_train)
str(y_test); str(y_train)

str(subject_test); str(y_test); str(X_test)

merged_test <- cbind(subject_test, y_test, X_test)
merged_train <- cbind(subject_train, y_train, X_train)
merged_alldata <- rbind(merged_test, merged_train)

##
## Extracting only the measurements on the mean and standard deviation for each measurement.
##

features <- read.table("./Project/UCI HAR Dataset/features.txt", sep="")
grep("mean()", features$V2)
grep("std()", features$V2)
grep("mean()|std()", features$V2)

mean_std_meas <- cbind(merged_alldata[,1:2],merged_alldata[, grep("mean()|std()", features$V2) + 2])

##
##  Uses descriptive activity names to name the activities in the data set
##

activities <- read.table("./Project/UCI HAR Dataset/activity_labels.txt", sep="")
mean_std_meas$V1.1 <- activities$V2[mean_std_meas$V1.1]

##
##  Appropriately labels the data set with descriptive variable names.
## 

colnames(mean_std_meas) [1] <- "subject.num"
colnames(mean_std_meas) [2] <- "activity.name"

features$V2 <- gsub("-", ".", features$V2)
features$V2 <- sub("^t", "time", features$V2)
features$V2 <- sub("^f", "frequency", features$V2)

colnames(mean_std_meas) [3:81] <- features$V2 [grep("mean()|std()", features$V2)]

##
## From the data set in step 4, creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
##

Xmean_std_meas <- mean_std_meas
Xmean_std_meas$subject.num <- as.factor(Xmean_std_meas$subject.num)
Xmean_std_meas$activity.name <- as.factor(Xmean_std_meas$activity.name)

# Xmean_std_meas <- Xmean_std_meas[order(Xmean_std_meas$subject.num, Xmean_std_meas$activity.name),]

library(dplyr)

Xmean_std_meas <- arrange (Xmean_std_meas, subject.num, activity.name)
grouped_dset <- group_by(Xmean_std_meas, subject.num, activity.name)
tidy_dset <- summarize_each (grouped_dset, funs(mean))

setwd(wd_corrente)

write.table(tidy_dset, file = "./Project/tidy_dset.txt", row.name=FALSE)
