# Getting-and-cleaning-data-Project
##Course Project



#This repository contains the script for cleaning the given dataset


* We can download all project-related materials in the form of a zip file from the url 
 (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 


*Unzip the file to get "UCI HAR Dataset"

*Put run_analysis.R into C:/Users/yourname/Documents/UCI HAR Dataset/

*In RStudio,set the working directory 
	*setwd("C:/Users/yourname/Documents/UCI HAR Dataset/")

*then type: 

	*source("run_analysis.R)

 
####the script run_analysis.R does the following

*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement.
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names.
*creates a second, independent tidy data set with the average of each variable for each activity and each subject.


*after running the script,it generates two files in the UCI HAR dataset

	
	*merged_clean_data.txt 

	*Tidy_data.txt	


*Use data <- read.table("Tidy_data.txt") to read the data. It is 180x68 data table because there are 30 subjects and 6 activity


