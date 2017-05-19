#download the file
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download.file(url,"Dataset.zip")

#unzip(zipfile = "Dataset.zip" )




#set working directory
##setwd("C:/Users/Adamantium/Documents/UCI HAR Dataset/")


#Read the training data files

trainData <- read.table("./train/X_train.txt")
trainLabel <- read.table("./train/y_train.txt")
trainSubject <-read.table("./train/subject_train.txt")


#Read the test data files

testData <- read.table("./test/X_test.txt")
testLabel <- read.table("./test/y_test.txt")
testSubject <-read.table("./test/subject_test.txt")

##1.Merges the training and the test sets to create one data set


joinData <- rbind(trainData, testData)
dim(joinData)

joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel)

joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)



##2.Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table("./features.txt")
dim(features)

meanAndStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanAndStd)

joinData <-joinData[,meanAndStd]

names(joinData) <- gsub("\\(\\)", "", features[meanAndStd, 2]) # replaces all brackets
names(joinData) <- gsub("-", "", names(joinData)) # replace all hyphens
names(joinData) <- gsub("mean", "Mean", names(joinData))
names(joinData) <- gsub("std", "Std", names(joinData)) 

##3.Uses descriptive activity names to name the activities in the data set

#read descriptive active names
activity <- read.table("./activity_labels.txt")

activity[, 2] <- tolower(gsub("_", "", activity[, 2]))#gsub replace all underscores
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))#changes the 8th letterin 2nd column  element in the second rowto easily readable 
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))#changes the 8th letterin 2nd column element of the 3rd row  to easily readable 

joinLabel[, 1] <- activity[joinLabel[, 1], 2]
names(joinLabel) <- "activity"

##4.Appropriately labels the data set with descriptive variable names

names(joinSubject) <- "subject"
cleanData <- cbind(joinSubject, joinLabel, joinData)

# labelling the descriptive variables

names(cleanData)<-gsub("^t", "time", names(cleanData))
names(cleanData)<-gsub("^f", "frequency", names(cleanData))
names(cleanData)<-gsub("Acc", "Accelerometer", names(cleanData))
names(cleanData)<-gsub("Gyro", "Gyroscope", names(cleanData))
names(cleanData)<-gsub("Mag", "Magnitude", names(cleanData))
names(cleanData)<-gsub("BodyBody", "Body", names(cleanData))
write.table(cleanData, "merged_clean_data.txt")

#5.# creates a second, independent tidy data set with the average of each
#each variable for each activity and each subject

subjectLen <- length(table(joinSubject))

activityLen <- dim(activity)[1]

columnLen <- dim(cleanData)[2]

result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 

result <- as.data.frame(result)

colnames(result) <- colnames(cleanData)

row <- 1

for(i in 1:subjectLen) {
  
  for(j in 1:activityLen) {
    
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    
    result[row, 2] <- activity[j, 2]
    
    sub1 <- i == cleanData$subject
    
    sub2 <- activity[j, 2] == cleanData$activity
    
    result[row, 3:columnLen] <- colMeans(cleanData[sub1&sub2, 3:columnLen])
    
    row <- row + 1
    
  }
  
}

write.table(result, "Tidy_data.txt",row.name=FALSE)# created final tidy dataset









